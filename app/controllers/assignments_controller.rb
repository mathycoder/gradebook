class AssignmentsController < ApplicationController

  before_action :find_klass

  def new
    @assignment = Assignment.new
    @assignment.grades.build()
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to(klass_path(@klass), alert: "Assignment successfully added")
    else
      render 'new'
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to(klass_path(@klass), alert: "Assignment successfully updated")
    else
      render 'edit'
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.grades.destroy_all
    @assignment.destroy
    redirect_to(klass_path(@klass), alert: "Assignment deleted")
  end

  private

    def find_klass
      @klass = Klass.find(params[:klass_id])
    end

    def assignment_params
      params.require(:assignment).permit(:name, :learning_target_id, :date, :grades_attributes => {})
    end

end
