class ApplicationController < ActionController::Base

  def current_user
    Teacher.find_by(id: session[:user_id])
  end
  
end
