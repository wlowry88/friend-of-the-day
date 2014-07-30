class SessionsController < ApplicationController
  def create
    @response = env["omniauth.auth"]
    @user = User.from_omniauth(@response)
    contacts = @user.get_contacts(@response)
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end