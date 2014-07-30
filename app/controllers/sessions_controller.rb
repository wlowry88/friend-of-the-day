class SessionsController < ApplicationController
  def create
  	# binding.pry
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = @token
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
      :api_method => service.events.list,
    # we need to figure out how to get the birthday calendar id for all users"
      :parameters => {'calendarId' => '8bedhb3o4g5l2dtkil2k34tjm2dgum9k@import.calendar.google.com'},
      :headers => {'Content-Type' => 'application/json'})
    binding.pry
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end