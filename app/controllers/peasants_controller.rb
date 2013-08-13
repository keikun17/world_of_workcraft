class PeasantsController < ApplicationController
  def create
    @peasant = Peasant.new(peasant_params)
    if @peasant.save
      # redirect things
    else
      # render things
    end
  end

  private

  # Write the peasant strong parameter code here
  def peasant_params
    params[:peasant]
  end
end
