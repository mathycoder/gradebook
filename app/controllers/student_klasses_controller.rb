class StudentKlassesController < ApplicationController
  skip_before_action :require_login
  before_action :require_student_login

  def index
  end

end
