class AssignmentsController < ApplicationController

  def new
    @klass = Klass.find(params[:klass_id])
  end

end
