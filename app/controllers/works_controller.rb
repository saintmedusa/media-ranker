class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.category_hash
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work)
      return
    else
      render :new
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    end
    @work.destroy
    redirect_to works_path
    return
  end

  def top_10
    @works = {}
    Work.category_hash.each do |category, works|
      @works[category] = Work.top_10(works)
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :published, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
