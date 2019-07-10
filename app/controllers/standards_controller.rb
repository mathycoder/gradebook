class StandardsController < ApplicationController
  def new
    @standard = Standard.new
  end

  def create
    @standard = Standard.new(standard_params)
    render 'new'
  end

  private

    def standard_params
      params.require(:standard).permit(:grade, :grade_id, :standard_notation, :description, :alt_standard_notation, :api_standard_id)
    end
end
