class AssignmentsController < ApplicationController
  before_action :find_klass_nested_route
  before_action :find_assignment, only: [:edit, :update, :destroy]
  before_action :require_lts

  def new
    @assignment = Assignment.new
    @assignment.grades.build()
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save ? (redirect_to(klass_path(@klass), alert: "Assignment successfully added")) : (render 'new')
  end

  def edit
  end

  def update
    @assignment.update(assignment_params) ? (redirect_to(klass_path(@klass), alert: "Assignment successfully updated")) : (render 'edit')
  end

  def destroy
    @assignment.grades.destroy_all
    @assignment.destroy
    redirect_to(klass_path(@klass), alert: "Assignment deleted")
  end

  private

    def find_assignment
      @assignment = Assignment.find_by(id: params[:id])
      redirect_to(klass_path(@klass), alert: "You don't have access to that assignment") if @assignment.nil? || !@klass.assignments.include?(@assignment)
    end

    def assignment_params
      params.require(:assignment).permit(:name, :learning_target_id, :date, :grades_attributes => {})
    end

    def require_lts
      unless !@klass.learning_targets.empty?
        flash[:error] = "Before you can add assignments, you need to add your first learning target"
        redirect_to(klass_learning_targets_url(@klass))
      end
    end

end
