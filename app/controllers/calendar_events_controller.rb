class CalendarEventsController < ApplicationController
  def new
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    
    calendar_ids = service.list_calendar_lists.items.map { |calendar| calendar.id }
    @events = calendar_ids
      .map { |id| service.list_events(id, time_min: start_time, time_max: end_time) }
      .map { |event| event.items }
      .flat_map { |item| item }
      .map { |name| name.summary }

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

  def start_time
    DateTime.strptime(params[:start].values.join, '%m%d%Y%H%M').rfc3339
  end

  def end_time
    DateTime.strptime(params[:end].values.join, '%m%d%Y%H%M').rfc3339
  end
end
