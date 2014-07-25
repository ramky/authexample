class Api::V1::RegistrationsController < ApplicationController
  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      @user = User.new(user_params)
      if @user.save
        render_success
      else
        render_error
      end
    else
      render_error("Passwords do not match")
    end
  end

private
  def render_success
    render status: 200,
      json: {
      success: true,
      info: 'You have Registered!',
      data: {
        user: @user.id,
        token: @user.token
      }
    }
  end

 def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end
