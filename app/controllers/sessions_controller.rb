class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :already_logged_in, only: [:new]

  def new
    @session = Session.new
  end

  def create
    if !request.env['omniauth.auth'].nil?
      @teacher = Teacher.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.picture_url = auth['info']['image']
        u.password_digest = SecureRandom.urlsafe_base64
      end
      session[:user_id] = @teacher.id
      redirect_to(klasses_path)
    else
      if params[:session][:type] == "teacher"
        @teacher = Teacher.find_by(email: params[:session][:email])
        if @teacher.nil?
          redirect_to(login_path, alert: "No teacher account matches that email")
        elsif @teacher.authenticate(params[:session][:password]) && @teacher.uid.nil?
          session[:user_id] = @teacher.id
          redirect_to(klasses_path)
        else
          redirect_to(login_path, alert: "Incorrect password")
        end
      else
        #redirect_to(login_path, alert: "You can only login as a Teacher currently")
        @student = Student.find_by(first_name: params[:session][:email])
        if @student.nil?
          redirect_to(login_path, alert: "No student account matches that email")
        else
          session[:student_id] = @student.id
          binding.pry
          session.clear
        end
      end
    end
  end

  def destroy
    session.clear
    redirect_to(login_path)
  end

  private

    def auth
      request.env['omniauth.auth']
    end

end
