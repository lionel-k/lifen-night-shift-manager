class Worker < ApplicationRecord
  has_many :shifts

  def price_per_shift
    case status
    when "medic"
      270
    when "interne"
      126
    when "interim"
      480
    else
      0
    end
  end

  def is_interim?
    status == "interim"
  end
end
