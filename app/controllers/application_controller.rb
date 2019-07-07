class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    Teacher.find_by(id: session[:user_id])
  end

end
