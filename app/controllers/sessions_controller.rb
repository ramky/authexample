class SessionsController < ApplicationController
  def create
    @user = User.where(email: params[:email]).first
    if @user && @user.authentication(params[:password])
      session[:token] = @user.token
      render_logged_in
    else
      render_error('Invalid credentials')
    end
  end

   def destroy
     session[:token] = nil

   end

private
  def render_logged_in
    render status: 200,
      json: {
      success: true,
      info: 'Logged in',
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
