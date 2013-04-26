class Task < ActiveRecord::Base
  attr_accessible :done, :due_date, :name
end
