class TeachersController < ApplicationController
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      teacher_path(@teacher)
    else
      render 'new'
    end
  end

  def show
  end 

  private

    def teacher_params
      params.require(:teacher).permit(:name, :grade, :class)
    end
end
