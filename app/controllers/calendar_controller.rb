class CalendarController < ApplicationController
  def index
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    
    calendar_ids = service.list_calendar_lists.items.map { |calendar| calendar.id }
    event_list = calendar_ids.map{ |id| service.list_events(id, time_min: 1.hour.ago.rfc3339, time_max: DateTime.current.end_of_day) }
    byebug

  rescue Google::Apis::AuthorizationError
    response = client.refresh!
    session[:authorization] = session[:authorization].merge(response)
    retry
  end

  def authorize
    
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendar_url
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
end
