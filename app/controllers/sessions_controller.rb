class SessionsController < ApplicationController
  def create
    @response = env["omniauth.auth"]
    if User.where(@response.slice(:provider, :uid)).empty?
      @user = User.from_omniauth(@response)
      friends = @user.get_friends(@response)
      @user.create_friends(friends)
      @user.remove_duplicates
      session[:user_id] = @user.id
      redirect_to friends_path
    else
      @user = User.from_omniauth(@response)
      session[:user_id] = @user.id
      redirect_to friends_path
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
