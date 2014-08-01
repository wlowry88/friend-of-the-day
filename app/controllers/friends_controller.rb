class FriendsController < ApplicationController

	def create
		@friend = Friend.new(friend_params)
		if @friend.save
			redirect_to friends_path
		else
			redirect_to friends_path
		end
	end

	def index
		@friend_of_the_day = current_user.get_friend_of_the_day if logged_in?
		@user = current_user
		@friend = Friend.new
	end

	def update
		@user = current_user
		@friend = Friend.find(params[:id])
		@friend.update(friend_params)
		begin
			current_user.set_friend_of_the_day if (current_user.get_friend_of_the_day == nil)
		rescue
		end
	end

	def destroy
		@friend = Friend.find(params[:id])
		@friend.destroy
		redirect_to friends_path
	end


	private

	def friend_params
		params.require(:friend).permit(:name, :email, :birthday, :phone_number, :close_friend, :user_id)
	end

end
