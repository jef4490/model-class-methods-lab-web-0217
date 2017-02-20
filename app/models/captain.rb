class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications


  def self.catamaran_operators
    # catamarans = Boat.all.select{
    #     |boat| boat.classifications.any?{
    #       |c| c.name == "Catamaran"}
    #       }
    #
    # cat_names = catamarans.map{|b| b.name}
    # y = self.all.select{|capn| capn.boats.any?{|boat| cat_names.any?{|cat| boat.name == cat}}}
    # name_array = y.map{|c| c.name}
    # z = self.where({name: name_array})
    x = self.includes(:classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    # sailboats = Boat.all.select{
    #     |boat| boat.classifications.any?{
    #       |c| c.name == "Sailboat"}
    #       }
    #
    # sail_names = sailboats.map{|b| b.name}
    # y = self.all.select{|capn| capn.boats.any?{|boat| sail_names.any?{|sail| boat.name == sail}}}
    # name_array = y.map{|c| c.name}
    # z = self.where({name: name_array})
    x = self.includes(:classifications).where("classifications.name = ?", "Sailboat").group("captains.name")
  end

  def self.talented_seamen
    # sailboats = Boat.all.select{
    #     |boat| boat.classifications.any?{
    #       |c| c.name == "Sailboat"}
    #       }
    # motorboats = Boat.all.select{
    #     |boat| boat.classifications.any?{
    #       |c| c.name == "Motorboat"}
    #       }
    #
    #
    # sail_names = sailboats.map{|b| b.name}
    # motorboat_names = motorboats.map{|b| b.name}
    #
    # y = self.all.select{|capn| capn.boats.any?{|boat| sail_names.any?{|sail| boat.name == sail}}}.map{|c| c.name}
    # x = self.all.select{|capn| capn.boats.any?{|boat| motorboat_names.any?{|motor| boat.name == motor}}}.map{|c| c.name}
    # name_array = y.select{|name| x.include?(name)}
    # z = self.where({name: name_array})
    x = self.includes(:classifications).where("classifications.name = ?", "Sailboat").group("captains.name")
    y = self.includes(:classifications).where("classifications.name = ?", "Motorboat").group("captains.name")
    x.where({name: y.pluck(:name)})
  end

  def self.non_sailors
      # sailboats = Boat.all.select{
      #     |boat| boat.classifications.any?{
      #       |c| c.name == "Sailboat"}
      #       }
      # sail_names = sailboats.map{|b| b.name}
      # y = self.all.select{|capn| capn.boats.any?{|boat| sail_names.any?{|sail| boat.name == sail}}}
      # name_array = y.map{|c| c.name}
      # z = self.where.not({name: name_array})
      # y = self.includes(:classifications).where.not("classifications.name = ?", "Sailboat").group("captains.name")
      x = self.includes(:classifications).where("classifications.name = ?", "Sailboat").group("captains.name")
      self.where.not({name: x.pluck(:name)}).order(:id)
  end


end
