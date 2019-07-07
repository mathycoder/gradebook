class StudentsController < ApplicationController
  def index
    @klass = Klass.find(params[:klass_id])
    if params[:query] && !params[:query].empty?
      @students = Student.where('first_name LIKE ? OR last_name LIKE ? OR klass LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").all
    else
      @students = Student.all - @klass.students
    end
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @student = Student.find(params[:id])

    if !@klass.students.include?(@student)
      @klass.students << @student
    else
      @klass.students.delete(@student)
    end
    redirect_to(klass_students_path(@klass))
  end
end
