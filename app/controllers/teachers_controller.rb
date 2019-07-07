class TeachersController < ApplicationController
  def new
    @teacher = Teacher.new
  end
end
