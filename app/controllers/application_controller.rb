class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  after_filter :cors_set_response_header

  def cors_set_response_header
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
