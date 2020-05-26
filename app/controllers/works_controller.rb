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
      flash[:success] = "#{@work.category} successfully added!"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "Work wasn't created, try again"
      render :new, status: :bad_request
      return
    end
  end

  def edit; end

  def update
    if @work.update(work_params)
      flash[:success] = "Changes successful."
      redirect_to work_path
      return
    else
      flash.now[:error] = "Edit unsuccessful, try again."
      render :edit
      return
    end
  end

  def destroy
    title = @work.title
    @work.destroy
    flash[:success] = "#{title} deleted."
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
    if @work.nil?
      head :not_found
      return
    end
  end

end
