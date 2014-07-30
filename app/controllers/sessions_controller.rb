class SessionsController < ApplicationController
  def create
    @response = env["omniauth.auth"]
    @user = User.from_omniauth(@response)
    friends = @user.get_friends(@response)
    @user.create_friends(friends)
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end