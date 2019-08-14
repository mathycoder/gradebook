class KlassesController < ApplicationController
  before_action :find_klass, only: [:show, :edit, :update, :destroy]
  before_action :require_lts, only: [:show]

  def redirect
    @klass = Klass.find_by(id: params[:klass][:id])
    @klass ? redirect_to(klass_path(@klass)) : redirect_to(klasses_path)
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
      current_user.klasses << @klass
      redirect_to(klasses_path, alert: "Class successfully created")
    else
      render 'new'
    end
  end

  def index
    @klasses = current_user.klasses.sorted_by_period
  end

  def show
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
      @klass = Klass.find_by(id: params[:id])
      redirect_to(klasses_url, alert: "You don't have access to that class") if @klass.nil? || !current_user.klasses.include?(@klass)
    end

    def klass_params
      params.require(:klass).permit(:name, :subject, :grade, :period, :id)
    end

end
