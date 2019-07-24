class StudentsController < ApplicationController
  before_action :find_klass_nested_route, :except => [:new, :create]
  before_action :find_student, only: [:show, :update]
  before_action :require_lts, only: [:index]

  def new
    @student = Student.new
    set_students_instance_variable()
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to(new_student_url(), alert: "#{@student.first_name} added to the school")
    else
      render 'new'
    end
  end

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

    def student_params
      params.require(:student).permit(:first_name, :last_name, :grade, :klass)
    end

    def find_student
      @student = Student.find_by(id: params[:id])
      redirect_to(klass_students_url(@klass), alert: "You don't have access to that student") if @student.nil?
    end

    def set_students_instance_variable()
      if params[:query] && !params[:query].empty?
        @students = Student.where('first_name LIKE ? OR last_name LIKE ? OR klass LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").all
        @students = @students - @klass.students if @klass
      else
        @students = Student.all.order(klass: :asc).order(last_name: :asc)
        @students = @students - @klass.students if @klass
      end
    end

    def add_student_to_klass
      @klass.students << @student
      @klass.assignments.each do |assignment|
        assignment.grades.find_or_create_by(student_id: @student.id)
      end
    end

end
