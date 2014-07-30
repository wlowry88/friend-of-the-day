class UsersController < ApplicationController

  def index

  end
  def create

  end

  def update
    @user = User.find(params[:id])
    original_number = @user.phone_number
    new_number = user_params[:phone_number]
    if new_number != original_number
      if @user.update(user_params)
        @user.send_updated_message
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'Your phone number was updated successfully.' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to root_path, notice: 'That number is already on record :)' }
        format.json { render :show, status: :ok, location: @user }
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
