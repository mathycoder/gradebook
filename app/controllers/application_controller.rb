class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :current_student_user, :student_logged_in?
  before_action :require_login

  def current_user
    Teacher.find_by(id: session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def current_student_user
    Student.find_by(id: session[:student_id])
  end

  def student_logged_in?
    !session[:student_id].nil?
  end

  private

  def find_klass_nested_route
    @klass = Klass.find_by(id: params[:klass_id])
    redirect_to(klasses_url, alert: "You don't have access to that class") if @klass.nil? || !current_user.klasses.include?(@klass)
  end

  def require_login
    if !logged_in? && !student_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(login_url)
    elsif student_logged_in?
      flash[:error] = "You must be logged into a teacher account to access this section"
      redirect_to(s_klasses_url)
    end
  end

  def require_student_login
    unless student_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(login_url)
    end
  end

  def already_logged_in
    redirect_to(klasses_path) if logged_in?
  end


  def require_lts
    redirect_to(klass_learning_targets_url(@klass)) if @klass.learning_targets.empty?
  end
end
