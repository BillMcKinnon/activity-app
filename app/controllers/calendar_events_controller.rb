class CalendarEventsController < ApplicationController
  def new
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    calendar_ids = service.list_calendar_lists.items.map { |calendar| calendar.id }

    events = calendar_ids
      .map { |id| service.list_events(id, time_min: convert_params(params[:start]), time_max: convert_params(params[:end])) }
      .map { |event| event.items }
      .flat_map { |item| item }
    
    @events_with_times = events
      .reject { |event_resource| event_resource.start.nil? || event_resource.end.nil? }
      .reject { |event_time| event_time.start.date_time.nil? || event_time.end.date_time.nil? }

  rescue Google::Apis::AuthorizationError
    response = client.refresh!
    session[:authorization] = session[:authorization].merge(response)
    retry
  end
  
  private
  def client_options
    {
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: callback_url
    }
  end

  # Ensures params are ordered correctly, adds zero-padding to any values less
  # than 10 and then produces the required RFC3339 timestamp.
  def convert_params(original_params)
    ordered_params = [:month, :day, :year, :hour, :minute].map { |date_part| original_params[date_part] }
    converted_params = ordered_params.map { |value| sprintf('%02d', value.to_i) }
    DateTime.strptime(converted_params.join, '%m%d%Y%H%M').rfc3339
  end
end

