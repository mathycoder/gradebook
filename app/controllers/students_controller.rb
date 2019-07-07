class StudentsController < ApplicationController
  def index
    @klass = Klass.find(params[:klass_id])
    #need to find all the students that don't have the current teacher id
    @students = Student.all
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @student = Student.find(params[:id])
    @klass.students << Student.find(params[:id]) if !@klass.students.include?(@student)
    redirect_to(klass_students_path(@klass))
  end
end
