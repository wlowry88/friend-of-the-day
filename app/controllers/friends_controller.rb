class FriendsController < ApplicationController

	def create
		#will use the fbook api to find or create friends
		@friend = Friend.new(friend_params)
		if @friend.save
			redirect_to friends_path
		else
			redirect_to root_path
		end
	end

	def index
		@user = current_user
		@friend = Friend.new
	end

	def edit
		@friend = Friend.find(params[:id])
	end

	def update
		@friend = Friend.find(params[:id])
		@friend.update(friend_params)
		begin
			current_user.set_friend_of_the_day if (current_user.get_friend_of_the_day == nil)
		rescue
		end
		redirect_to friends_path
	end


	private

	def friend_params
		params.require(:friend).permit(:name, :email, :birthday, :phone_number, :close_friend, :user_id)
	end

end
