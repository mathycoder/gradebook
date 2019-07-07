class SessionsController < ApplicationController
  def new
    @teacher = Teacher.new
  end
end
