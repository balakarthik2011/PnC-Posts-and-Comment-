class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  #skip_before_filter :verify_authenticity_token

 private
end
