class WorkersController < ApplicationController
  before_action :set_worker, only: [:edit, :update]

  def new
    @worker = Worker.new
  end

  def create
    worker = Worker.new(worker_params)
    if worker.save
      redirect_to root_path
    else
      @worker = Worker.new
      render :new
    end
  end

  def edit
  end

  def update
    @worker.update(worker_params)
    redirect_to root_path
  end

  private

  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:first_name, :status)
  end
end
