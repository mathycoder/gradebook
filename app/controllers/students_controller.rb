class StudentsController < ApplicationController
  def index
    @klass = Klass.find(params[:klass_id])
    @students = Student.all - @klass.students
    #Student.joins(:klass_students).where("klass_id = ?", params[:klass_id])
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @student = Student.find(params[:id])
    @klass.students << Student.find(params[:id]) if !@klass.students.include?(@student)
    redirect_to(klass_students_path(@klass))
  end
end
