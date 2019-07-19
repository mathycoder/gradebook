class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    Teacher.find_by(id: session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end

end
