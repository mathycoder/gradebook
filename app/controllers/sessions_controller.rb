class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.find_by(email: params[:teacher][:email])
    if @teacher.authenticate(params[:teacher][:password])
      session[:user_id] = @teacher.id
      redirect_to(klasses_path)
    else
      redirect_to(login_path)
    end
  end

  def destroy
    session.clear
    redirect_to(login_path)
  end

end
