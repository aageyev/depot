class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  protected
  def authorize
    redirect_to login_url, notice: "Please log in" unless User.find_by(id: session[:user_id])
  end
end
