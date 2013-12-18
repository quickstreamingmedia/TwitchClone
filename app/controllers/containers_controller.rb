class ContainersController < ApplicationController

  def destroy
    container = Container.find(params[:id]);
    container.destroy
    render json: nil
  end

end
