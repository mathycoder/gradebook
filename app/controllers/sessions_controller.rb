class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :already_logged_in, only: [:new]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.find_by(email: params[:teacher][:email])
    if @teacher.nil?
      redirect_to(login_path, alert: "No account matches that email") if !@teacher
    elsif @teacher.authenticate(params[:teacher][:password])
      session[:user_id] = @teacher.id
      redirect_to(klasses_path)
    else
      redirect_to(login_path, alert: "Incorrect password")
    end
  end

  def destroy
    session.clear
    redirect_to(login_path)
  end

end
