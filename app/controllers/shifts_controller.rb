class ShiftsController < ApplicationController

  def new
    @shift = Shift.new
  end

  def create
    worker = Worker.find(params[:shift][:worker_id])
    shift = Shift.new(shift_params)
    shift.worker = worker
    if shift.save
      redirect_to root_path
    else
      render :new
    end
  end


  def compute
    wages = {}
    total_wages = 0
    interim_shifts = 0
    shifts = Shift.all
    shifts.each do | shift|
      worker_id = shift.worker.id
      bonus = shift.is_on_weekend? ? 2 : 1
      price = shift.worker.price_per_shift * bonus
      total_wages += price
      interim_shifts += shift.worker.is_interim? ? 1 : 0
      if wages.key? worker_id
        wages[shift.worker.id] += price
      else
        wages[shift.worker.id] = price
      end
    end

    commission = total_wages * 0.05 + interim_shifts * 80

    @result = { workers: wages.map { |wage| {id: wage[0], price: wage[1]} },
    commission: {pdg_fee: commission, interim_shifts: interim_shifts }}
  end

  private

  def shift_params
    params.require(:shift).permit(:start_date, :worker_id)
  end
end
