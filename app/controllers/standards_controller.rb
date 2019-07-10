class StandardsController < ApplicationController
  def new
    @standard = Standard.new
  end
end
