class KlassesController < ApplicationController

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
      current_user.klasses << @klass
      redirect_to(klass_path(@klass), alert: "Class successfully created")
    else
      render 'new'
    end
  end

  def index
    @klasses = current_user.classes_sorted_by_period
  end

  def show
    @klass = Klass.find(params[:id])
    redirect_to(klass_learning_targets_path(@klass)) if @klass.learning_targets.empty?
  end

  def edit
    @klass = Klass.find(params[:id])
  end

  def update
    @klass = Klass.find(params[:id])
    if @klass.update(klass_params)
      redirect_to(klass_path(@klass), alert: "Class successfully updated")
    else
      render 'edit'
    end
  end

  def destroy
    @klass = Klass.find(params[:id])
    @klass.destroy
    redirect_to(klasses_path, alert: "Class successfully deleted")
  end

  private

    def klass_params
      params.require(:klass).permit(:name, :subject, :grade, :period)
    end

end
