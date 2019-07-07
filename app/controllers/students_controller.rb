class StudentsController < ApplicationController
  def index
    @klass = Klass.find(params[:klass_id])
    @students = Student.joins(:klass_students).where("klass_id = ?", params[:klass_id])
    Author.joins(:articles).where(articles: { author: author })
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @student = Student.find(params[:id])
    @klass.students << Student.find(params[:id]) if !@klass.students.include?(@student)
    redirect_to(klass_students_path(@klass))
  end
end
