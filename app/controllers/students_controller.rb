class StudentsController < ApplicationController
  before_action :find_klass
  before_action :require_lts, only: [:index]

  def redirect
    @student = Student.find_by(id: params[:student][:id])
    @student ? redirect_to(klass_student_path(@klass, @student)) : redirect_to(klass_students_path(@klass))
  end

  def index
    if params[:query] && !params[:query].empty?
      @students = Student.where('first_name LIKE ? OR last_name LIKE ? OR klass LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").all - @klass.students
    else
      @students = Student.all.order(klass: :asc).order(last_name: :asc) - @klass.students
    end
    @mystudents = @klass.students.order(last_name: :asc)
  end

  def show
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])

    if !@klass.students.include?(@student)
      @klass.students << @student
      @klass.assignments.each do |assignment|
        assignment.grades.find_or_create_by(student_id: @student.id)
      end
    else
      @klass.students.delete(@student)
    end
    redirect_to(klass_students_path(@klass))
  end

  private

    def find_klass
      @klass = Klass.find(params[:klass_id])
    end

end
