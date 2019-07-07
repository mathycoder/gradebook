class SessionsController < ApplicationController
  def new
    @teacher = Teacher.new
  end

  def create
    binding.pry 
  end
end
