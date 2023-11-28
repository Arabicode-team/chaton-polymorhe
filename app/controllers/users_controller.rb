class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to profile_path, notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
        @user = current_user
        @user.destroy
        redirect_to root_path, notice: 'User was successfully destroyed.'
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  