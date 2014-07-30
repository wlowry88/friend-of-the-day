class StaticPagesController < ApplicationController

  def index
    @friends = current_user.friends if logged_in?
    @user = current_user
  end


  
end
