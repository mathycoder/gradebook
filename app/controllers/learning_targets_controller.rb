class LearningTargetsController < ApplicationController

  def new
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.new
    @standard = Standard.new
    @standard.learning_targets << @lt
    params[:query] ? @standards = Standard.by_grade(params[:query][:grade]) : @standards = []
  end

  def create
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.new(lt_params)

    if @lt.save
      @klass.learning_targets << @lt
      if @klass.learning_targets.length > 1
        redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully created")
      else
        redirect_to(klass_path(@klass), alert: "Learning Target successfully created")
      end
    else
      params[:query] ? @standards = Standard.by_grade(params[:query][:grade]) : @standards = [@lt.standard]
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
    if @lt.standard
      @standard = @lt.standard
    else
      @standard = Standard.new
      @lt.standard = @standard
    end

    if !params[:query] && @standard.id
      @standards = [@standard]
    elsif !params[:query]
      @standards = []
    else
      @standards = Standard.by_grade(params[:query][:grade])
    end
  end

  def update
    @klass = Klass.find(params[:klass_id])
    @lt = LearningTarget.find(params[:id])
    if @lt.update(lt_params)
      redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully updated")
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
    redirect_to(klass_learning_targets_path(@klass), alert: "Learning Target successfully deleted")
  end

  private

    def lt_params
      params.require(:learning_target).permit(:name, :level1, :level2, :level3, :level4, :standard_attributes => {}, :klasses_attributes => {})
    end

end
