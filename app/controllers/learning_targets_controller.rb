class LearningTargetsController < ApplicationController
  before_action :find_klass_nested_route
  before_action :find_lt, only: [:show, :edit, :update, :destroy]

  def redirect
    @lt = LearningTarget.find_by(name: params[:learning_target][:name])
    @lt ? redirect_to(klass_learning_target_path(@klass, @lt)) : redirect_to(klass_learning_targets_path(@klass))
  end

  def new
    ApiScraper.scrape_math_standards if Standard.all.empty?
    @lt = LearningTarget.new
    @standard = @lt.build_standard
    set_standards_based_on_search_query([])
  end

  def create
    @lt = @klass.learning_targets.build(lt_params)
    if @lt.save
      @klass.learning_targets << @lt
      @klass.learning_targets.length > 1 ? redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully created") : redirect_to(klass_path(@klass), alert: "Learning Target successfully created")
    else
      set_standards_based_on_search_query([@lt.standard])
      render 'new'
    end
  end

  def index
    @lts = @klass.learning_targets
  end

  def show
  end

  def edit
    set_standards_based_on_search_query([@lt.standard])
  end

  def update
    if @lt.update(lt_params)
      redirect_to(klass_learning_target_path(@klass, @lt), alert: "Learning Target successfully updated")
    else
      set_standards_based_on_search_query([@lt.standard])
      render 'edit'
    end
  end

  def destroy
    @lt.assignments.destroy_all
    @lt.destroy
    redirect_to(klass_learning_targets_path(@klass), alert: "Learning Target successfully deleted")
  end

  private

    def set_standards_based_on_search_query(current_standard)
      params[:query] ? @standards = Standard.by_grade(params[:query][:grade]) : @standards = current_standard
    end

    def find_lt
      @lt = LearningTarget.find_by(id: params[:id])
      redirect_to(klass_learning_targets_url(@klass), alert: "You don't have access to that learning target") if !@klass.learning_targets.include?(@lt)

    end

    def lt_params
      params.require(:learning_target).permit(:name, :level1, :level2, :level3, :level4, :standard_attributes => {}, :klasses_attributes => {})
    end

end
