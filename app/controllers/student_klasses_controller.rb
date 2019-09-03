class StudentKlassesController < ApplicationController
  skip_before_action :require_login
  before_action :require_student_login

  def index
  end

  def show
    @klass = Klass.find_by(id: params[:id])
  end

  def redirect
    @klass = Klass.find_by(id: params[:klass][:id])
    @klass ? redirect_to(s_klass_path(@klass)) : redirect_to(s_klasses_path)
  end

end
