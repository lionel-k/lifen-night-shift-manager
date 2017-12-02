require 'json'
require 'open-uri'

Shift.destroy_all
Worker.destroy_all

url_json_file = "https://raw.githubusercontent.com/honestica/ruby-jobs/master/level4/data.json"
data = JSON.parse(open(url_json_file).read)


data["workers"].each do |worker|
  Worker.create(id: worker["id"],first_name: worker["first_name"], status: worker["status"])
end

data["shifts"].each do |shift|
  worker = Worker.find(shift["user_id"])
  Shift.create(start_date: shift["start_date"], worker: worker)
end
