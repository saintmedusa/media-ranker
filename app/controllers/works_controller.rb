class WorksController < ApplicationController
  def index
    @works = Works.all
  end

  def show
    @work = Works.find_by(id: params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :published, :description)
  end
end
