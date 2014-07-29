class SessionsController < ApplicationController

	def new
		redirect_to users_path
	end

	def destroy
		reset_session
		redirect_to root_path
	end

end
