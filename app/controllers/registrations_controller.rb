class RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render status: 200,
        json: {
          success: true,
          info: 'Registered',
          data: {
            user: @user.id,
            auth_token: @user.token
          }
        }
    else
      render status: :unprocessable_entity,
        json: {
          success: false,
          info: @user.errors.messages,
          data: {}
        }
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
