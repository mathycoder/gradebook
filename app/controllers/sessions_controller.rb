class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :already_logged_in, only: [:new]

  def new
    @session = Session.new
  end

  def create
    binding.pry
    if !request.env['omniauth.auth'].nil?
      @teacher = Teacher.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.picture_url = auth['info']['image']
      end
    else
      if params[:session][:type] == "teacher"
        @teacher = Teacher.find_by(email: params[:session][:email])
        if @teacher.nil?
          redirect_to(login_path, alert: "No account matches that email") if !@teacher
        elsif @teacher.authenticate(params[:session][:password])
          session[:user_id] = @teacher.id
          redirect_to(klasses_path)
        else
          redirect_to(login_path, alert: "Incorrect password")
        end
      else
        redirect_to(login_path, alert: "You can only login as a Teacher currently")
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
