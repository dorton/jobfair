class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  check_authorization
  skip_authorization_check

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

end
