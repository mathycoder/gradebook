class LearningTargetsController < ApplicationController

  def new
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.new
  end

  def create
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.new(lt_params)
    if @lt.save
      @klass.learning_targets << @lt
      redirect_to(klass_learning_target_path(@klass, @lt))
    else
      render 'new'
    end
  end

  def index
    @klass = Klass.find(params[:klass_id])
    @lts = @klass.learning_targets
  end

  def show
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.find(params[:id])
  end

  def edit
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.find(params[:id])
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.find(params[:id])
    if @lt.update(lt_params)
      redirect_to(klass_learning_target_path(@klass, @lt))
    else
      render 'edit'
    end
  end

  def destroy
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.find(params[:id])
    @lt.assignments.each{|assignment| assignment.grades.destroy_all}
    @lt.assignments.destroy_all
    @lt.destroy
    redirect_to(klass_learning_targets_path(@klass))
  end

  private

    def lt_params
      params.require(:learning_target).permit(:name, :level1, :level2, :level3, :level4)
    end

end
