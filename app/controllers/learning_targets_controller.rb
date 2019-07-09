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
      redirect_to(klass_path(@klass))
    else
      render 'new'
    end
  end

  def index
    @klass = Klass.find(params[:klass_id])
    @lts = @klass.learning_targets
  end

  private

    def lt_params
      params.require(:learning_target).permit(:name)
    end

end
