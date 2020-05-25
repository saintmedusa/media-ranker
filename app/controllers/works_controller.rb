class WorksController < ApplicationController
  def index
    @works = Work.category_hash
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

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
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
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
    @work = Work.find_by(id: params[:id])
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
end
