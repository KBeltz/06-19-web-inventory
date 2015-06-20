require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

module Driver
  
  def self.list_yarns
    Yarn.all.each do |item|
      puts "#{item.id}. #{item.brand} #{item.name}: #{item.color} #{item.fiber}, $#{item.price} #{item.skeins} skeins"
    end
  end # list yarns

  def self.list_weights
    Weight.all.each do |item|
      puts "#{item.id}. #{item.weight}"
    end
  end # list weights

  def self.list_store_locations
    StoreLocation.all.each do |item|
      puts "#{item.id}. #{item.store_location}"
    end
  end # list store locations
end # module