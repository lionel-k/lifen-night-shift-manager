class Shift < ApplicationRecord
  belongs_to :worker

  def is_on_weekend?
    start_date_split = start_date.split("-")
    shift_date = Date.new(
      start_date_split[0].to_i,
      start_date_split[1].to_i,
      start_date_split[2].to_i
      )
    shift_date.saturday? || shift_date.sunday?
  end
end
