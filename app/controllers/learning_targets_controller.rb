class LearningTargetsController < ApplicationController
  before_action :find_klass
  before_action :find_lt, only: [:show, :edit, :update, :destroy]

  def new
    @lt = LearningTarget.new
    @standard = Standard.new
    @standard.learning_targets << @lt
    params[:query] ? @standards = Standard.by_grade(params[:query][:grade]) : @standards = []
  end

  def create
    @lt = LearningTarget.new(lt_params)

    if @lt.save
      @klass.learning_targets << @lt
      if @klass.learning_targets.length > 1
        redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully created")
      else
        redirect_to(klass_path(@klass), alert: "Learning Target successfully created")
      end
    else
      params[:query] ? @standards = Standard.by_grade(params[:query][:grade]) : @standards = [@lt.try(standard)]
      render 'new'
    end
  end

  def index
    @lts = @klass.learning_targets
  end

  def show
  end

  def edit
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
    if @lt.update(lt_params)
      redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully updated")
    else
      render 'edit'
    end
  end

  def destroy
    @lt.assignments.each{|assignment| assignment.grades.destroy_all}
    @lt.assignments.destroy_all
    @lt.destroy
    redirect_to(klass_learning_targets_path(@klass), alert: "Learning Target successfully deleted")
  end

  private

    def find_klass
      @klass = Klass.find(params[:klass_id])
    end

    def find_lt
      @lt = LearningTarget.find(params[:id])
    end

    def lt_params
      params.require(:learning_target).permit(:name, :level1, :level2, :level3, :level4, :standard_attributes => {}, :klasses_attributes => {})
    end

end
