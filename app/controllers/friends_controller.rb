class FriendsController < ApplicationController

	def create
		#will use the fbook api to find or create friends
	end

	def index
		@user = current_user
	end

	def update
		@friend = Friend.find(params[:id])
		@friend.update(friend_params)
		redirect_to friends_path
	end


	private

	def friend_params
		params.require(:friend).permit(:name, :email, :birthday, :phone_number, :close_friend)
	end

end
