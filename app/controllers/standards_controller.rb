class StandardsController < ApplicationController
  def new
    @standard = Standard.new
  end

  def create
    binding.pry 
    @standard = Standard.new(standard_params)
    render 'new'

  end

  private

    def standard_params
      params.require(:standard).permit(:org_id)
    end
end
