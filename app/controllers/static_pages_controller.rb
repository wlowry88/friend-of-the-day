class StaticPagesController < ApplicationController

  def index
    @friends = current_user.friends if logged_in?
    @user = current_user if logged_in?
    @friend_of_the_day = current_user.get_friend_of_the_day if logged_in?
  end


  
end
