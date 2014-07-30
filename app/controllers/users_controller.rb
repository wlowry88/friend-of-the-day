class UsersController < ApplicationController

  def index

  end
  def create

  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'Your phone number was updated successfully.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:phone_number)
  end

end
