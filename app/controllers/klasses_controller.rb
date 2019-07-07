class KlassesController < ApplicationController

  def add_students
    @klass = Klass.find(params[:klass_id])

    #need to find all the students that don't have the current teacher id
    @students = Student.all
  end

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

  def index
    @klasses = Klass.all
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

  def destroy
    @klass = Klass.find(params[:id])
    @klass.destroy
    redirect_to(klasses_path)
  end

  private

    def klass_params
      params.require(:klass).permit(:name, :subject, :grade, :period)
    end

end
