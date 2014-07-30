class FriendsController < ApplicationController

	def create
		#will use the fbook api to find or create friends
	end

	def index
		@user = current_user
	end

end
