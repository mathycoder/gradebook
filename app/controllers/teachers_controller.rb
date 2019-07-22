class TeachersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      session[:user_id] = @teacher.id
      redirect_to(klasses_path(), alert: "New account created")
    else
      render 'new'
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  private

    def teacher_params
      params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
    end
end
