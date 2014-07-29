class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def authentication_required
  	redirect_to new_session_path, notice: 'Log in to edit or delete your Post' if !logged_in?
  end

  helper_method def logged_in?
  	!!current_user
  end

  helper_method def current_user
  	@current_user ||= User.find(session[:id]) if session[:id]
  end


end
