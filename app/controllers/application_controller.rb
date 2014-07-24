class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  respond_to :json

  def render_error(message = nil)
    render status: :unprocessable_entity,
      json: {
      success: false,
      info: message || @user.errors.messages,
      data: {}
    }
  end
 end
