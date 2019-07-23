class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :require_login

  def current_user
    Teacher.find_by(id: session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(login_url)
    end
  end

  def already_logged_in
    redirect_to(klasses_path()) if logged_in?
  end

end
