class SessionsController < ApplicationController
  def create
    @response = env["omniauth.auth"]
    if User.where(@response.slice(:provider, :uid)).empty?
      @user = User.from_omniauth(@response)
      friends = @user.get_friends(@response)
      @user.create_friends(friends)
      @user.get_plus_info(@response)
      @user.remove_duplicates
      session[:user_id] = @user.id
      redirect_to friends_path
    else
      @user = User.from_omniauth(@response)
      session[:user_id] = @user.id
      redirect_to root_path
    end

    # # This is sessions controller for calendar
    # @auth = request.env["omniauth.auth"]
    # #Use the token from the data to request a list of calendars
    # @token = @auth["credentials"]["token"]
    # client = Google::APIClient.new
    # client.authorization.access_token = @token
    # service = client.discovered_api('calendar', 'v3')
    # @result = client.execute(
    #   :api_method => service.events.list,
    # # we need to figure out how to get the birthday calendar id for all users"
    #   :parameters => {'calendarId' => '8bedhb3o4g5l2dtkil2k34tjm2dgum9k@import.calendar.google.com'},
    #   :headers => {'Content-Type' => 'application/json'})

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  ##This is how you get a calendar Id for and search for friend's birthdays
  ##:api_method => service.calendar_list.list,
  ##:parameters => {},
  ## get the calendar id
end
