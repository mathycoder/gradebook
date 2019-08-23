class StudentsController < ApplicationController
  before_action :find_klass_nested_route, only: [:redirect, :index, :show]
  before_action :find_student, only: [:show, :edit, :destroy]
  before_action :student_in_klass?, only: [:show]
  before_action :require_lts, only: [:index]

  def new
    @student = Student.new
    @students = Student.filter_by(params[:query], nil)
  end

  def csv
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to(new_student_url, alert: "#{@student.first_name} added to the school")
    else
      @students = Student.filter_by(params[:query], nil)
      render 'new'
    end
  end

  def redirect
    @student = Student.find_by(id: params[:student][:id])
    @student ? redirect_to(klass_student_path(@klass, @student)) : redirect_to(klass_students_path(@klass))
  end

  def index
    @students = Student.filter_by(params[:query], @klass)
    @mystudents = @klass.students_by_last_name
  end

  def show
  end

  def edit
    @students = Student.filter_by(params[:query], @klass)
  end

  def update
    if params[:klass_id]
      find_klass_nested_route
      find_student
      @klass.students.include?(@student) ? @klass.students.delete(@student) : add_student_to_klass
      redirect_to(klass_students_path(@klass))
    else
      @student = Student.find_by(id: params[:id])
      if @student.update(student_params)
        redirect_to(new_student_path, alert: "Student updated")
      else
        @students = Student.filter_by(params[:query], @klass)
        render 'edit'
      end
    end
  end

  def destroy
    @student.destroy
    redirect_to(new_student_path, alert: "Student Deleted from School")
  end

  private

    def student_params
      params.require(:student).permit(:first_name, :last_name, :grade, :klass)
    end

    def find_student
      @student = Student.find_by(id: params[:id])
      redirect_to(klasses_url, alert: "You don't have access to that student") if @student.nil?
    end

    def student_in_klass?
      redirect_to(klass_students_url(@klass), alert: "You don't have access to that student") if !@klass.students.include?(@student)
    end

    def add_student_to_klass
      @klass.students << @student
      @klass.assignments.each do |assignment|
        assignment.grades.find_or_create_by(student_id: @student.id)
      end
    end

end
