class KlassesController < ApplicationController
  before_action :find_klass, only: [:show, :edit, :update, :destroy]

  def redirect
    @klass = Klass.find_by(id: params[:klass][:id])
    @klass ? redirect_to(klass_path(@klass)) : redirect_to(klasses_path())
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
      current_user.klasses << @klass
      redirect_to(klasses_path(), alert: "Class successfully created")
    else
      render 'new'
    end
  end

  def index
    @klasses = current_user.classes_sorted_by_period
  end

  def show
    redirect_to(klass_learning_targets_path(@klass)) if @klass.learning_targets.empty?
  end

  def edit
  end

  def update
    @klass.update(klass_params) ? (redirect_to(klass_path(@klass), alert: "Class successfully updated")) : (render 'edit')
  end

  def destroy
    @klass.destroy
    redirect_to(klasses_path, alert: "Class successfully deleted")
  end

  private

    def find_klass
      @klass = Klass.find(params[:id])
    end

    def klass_params
      params.require(:klass).permit(:name, :subject, :grade, :period, :id)
    end

end
