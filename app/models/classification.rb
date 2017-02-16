class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    # binding.pry
    long_boat = Boat.all.order("length DESC")
    # binding.pry
    long_boat.first.classifications
  end

end
