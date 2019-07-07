class StudentsController < ApplicationController
  def index
    @klass = Klass.find(params[:klass_id])
    #need to find all the students that don't have the current teacher id
    @students = Student.all
  end

  def update
    binding.pry 
  end
end
