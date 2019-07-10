class StandardsController < ApplicationController
  def new
    @standard = Standard.new
  end

  def create
    binding.pry 
  end
end
