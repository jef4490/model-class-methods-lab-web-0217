class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.order("id ASC LIMIT 5")
  end

  def self.dinghy
    self.all.where("length < 20")
  end

  def self.ship
    self.all.where("length > 20")
  end

  def self.last_three_alphabetically
    self.all.order("name DESC LIMIT 3")
  end

  def self.without_a_captain
    self.all.where(captain_id: nil)
  end

  def self.sailboats
    y = self.all.select{|boat| boat.classifications.any?{|c| c.name == "Sailboat"}}
    h = y.map{|x| x.name}
    z = Boat.where({name: h})
  end

  def self.with_three_classifications
    y = self.all.select{|boat| boat.classifications.count == 3}
    h = y.map{|x| x.name}
    z = Boat.where({name: h})
  end

end
