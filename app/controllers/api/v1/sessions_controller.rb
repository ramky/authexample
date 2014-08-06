class Api::V1::SessionsController < ApplicationController
  before_filter :authenticate, only: [:destroy]
  def create
    @user = User.where(email: params[:user][:email]).first
    if @user && @user.authenticate(params[:user][:password])
      #session[:token] = @user.token
      render_logged_in
    else
      render_error('Invalid credentials.')
    end
  end

   def destroy
     token = params[:id]
     @user = User.where(token: token).first
     if @user
       #session[:token] = nil
       @user.update_column(:token, nil)
       render_logout
     else
       render_error('Could not logout.')
     end
   end

private
  def render_logged_in
    render status: 200,
      json: {
      success: true,
      info: 'Logged in.',
      data: {
        token: @user[:token]
      }
    }
  end

  def render_logout
    render status: 200,
      json: {
      success: true,
      info: 'Logout',
      data: {}
    }
  end
end
