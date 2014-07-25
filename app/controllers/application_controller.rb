class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  respond_to :json
  helper_method :current_user

  def authenticate
    current_user || render_error('Unauthorized')
  end

  def current_user
    authenticate_with_http_token do |token, options|
      current_user = User.find_by(token: token)
    end
  end

  def render_error(message = nil)
    render status: :unprocessable_entity,
      json: {
      success: false,
      info: message || @user.errors.messages,
      data: {}
    }
  end
 end
