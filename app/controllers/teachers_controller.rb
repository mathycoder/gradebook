class TeachersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :find_teacher, only: [:show, :update, :destroy]
  before_action :get_uploaded_io, only: [:create, :update]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      upload_pic_to_server()
      update_teacher_pic()
      session[:user_id] = @teacher.id
      redirect_to(klasses_path(), alert: "New account created")
    else
      render 'new'
    end
  end

  def show
  end

  def update
    delete_pic_from_server()
    upload_pic_to_server()
    update_teacher_pic()
    redirect_to(teacher_path(@teacher), alert: "Profile pic updated")
  end

  def destroy
    @teacher.destroy
    session.clear
    redirect_to(login_path)
  end

  private

    def find_teacher
      @teacher = Teacher.find(params[:id])
    end

    def get_uploaded_io
      @uploaded_io = params[:teacher][:picture_url]
    end

    def teacher_params
      params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :picture_url)
    end

    def delete_pic_from_server()
      File.delete(Rails.root.join('app', 'assets', 'images', @teacher.picture_url))
    end

    def upload_pic_to_server()
      File.open(Rails.root.join('app', 'assets', 'images', 'uploads', @uploaded_io.original_filename), 'wb') do |file|
        file.write(@uploaded_io.read)
      end
    end

    def update_teacher_pic()
      @teacher.update(picture_url: "uploads/#{@uploaded_io.original_filename}")
    end
end
