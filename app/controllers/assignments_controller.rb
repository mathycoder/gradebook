class AssignmentsController < ApplicationController

  def new
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.new
    @assignment.grades.build()
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

  def edit
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.find(params[:id])
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to(klass_path(@klass))
    else
      render 'edit'
    end
  end

  def destroy
    @klass = Klass.find(params[:klass_id])
    @assignment = Assignment.find(params[:id])
    @assignment.grades.destroy_all
    @assignment.destroy
    redirect_to(klass_path(@klass))
  end

  private

    def assignment_params
      params.require(:assignment).permit(:name, :learning_target_id, :grades_attributes => {})
    end

end
