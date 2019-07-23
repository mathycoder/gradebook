class StudentsController < ApplicationController
  before_action :find_klass
  before_action :find_student, only: [:show, :update]
  before_action :student_in_class?, only: [:show]
  before_action :require_lts, only: [:index]

  def redirect
    @student = Student.find_by(id: params[:student][:id])
    @student ? redirect_to(klass_student_path(@klass, @student)) : redirect_to(klass_students_path(@klass))
  end

  def index
    set_students_instance_variable()
    @mystudents = @klass.students_by_last_name
  end

  def show
  end

  def update
    @klass.students.include?(@student) ? @klass.students.delete(@student) : add_student_to_klass()
    redirect_to(klass_students_path(@klass))
  end

  private

    def find_klass
      @klass = Klass.find_by(id: params[:klass_id])
      redirect_to(klasses_url(), alert: "That class doesn't exist") if @klass.nil?
    end

    def find_student
      @student = Student.find_by(id: params[:id])
      redirect_to(klass_students_url(@klass), alert: "That student doesn't exist") if @student.nil?
    end

    def student_in_class?
      redirect_to(klass_students_url(@klass), alert: "That student isn't in this class") if !@klass.students.include?(@student)
    end

    def set_students_instance_variable
      if params[:query] && !params[:query].empty?
        @students = Student.where('first_name LIKE ? OR last_name LIKE ? OR klass LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").all - @klass.students
      else
        @students = Student.all.order(klass: :asc).order(last_name: :asc) - @klass.students
      end
    end

    def add_student_to_klass
      @klass.students << @student
      @klass.assignments.each do |assignment|
        assignment.grades.find_or_create_by(student_id: @student.id)
      end
    end

end
