class AssignmentsController < ApplicationController

  def new
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.new
  end

  def create
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to(klass_path(@klass))
    else
      render 'new'
    end
  end

  private

    def assignment_params
      params.require(:assignment).permit(:name, :learning_target_id)
    end

end
