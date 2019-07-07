class KlassesController < ApplicationController

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
      redirect_to(klass_path(@klass))
    else
      render 'new'
    end
  end

  def show
    @klass = Klass.find(params[:id])
  end

  def edit
    @klass = Klass.find(params[:id])
  end

  def update
    @klass = Klass.find(params[:id])
    if @klass.update(klass_params)
      redirect_to(klass_path(@klass))
    else
      render 'edit'
    end 
  end

  private

    def klass_params
      params.require(:klass).permit(:name, :subject, :grade, :period)
    end

end
