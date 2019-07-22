class TeachersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      uploaded_io = params[:teacher][:picture_url]
      File.open(Rails.root.join('app', 'assets', 'images', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @teacher.picture_url = "uploads/#{uploaded_io.original_filename}"
      @teacher.save
      session[:user_id] = @teacher.id
      redirect_to(klasses_path(), alert: "New account created")
    else
      render 'new'
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    uploaded_io = params[:teacher][:picture_url]
    File.delete(Rails.root.join('app', 'assets', 'images', @teacher.picture_url))
    File.open(Rails.root.join('app', 'assets', 'images', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @teacher.picture_url = "uploads/#{uploaded_io.original_filename}"
    @teacher.save
    redirect_to(teacher_path(@teacher), alert: "Profile pic updated")
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    session.clear
    redirect_to(login_path)
  end

  private

    def teacher_params
      params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :picture_url)
    end
end
