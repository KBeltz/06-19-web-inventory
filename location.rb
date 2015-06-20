require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

class StoreLocation
  extend DatabaseMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :store_location
  
  # Initializes a new StoreLocation object
  #
  # id - Integer id primary key created in the 'store_locations' table
  # store_location  - String of item location
  #
  # Returns a StoreLocation object
  def initialize(store_location_options = {})
    @id = store_location_options["id"]
    @store_location = store_location_options["store_location"]
  end
  
  # in_location - an Array of valid location IDS.
  # Functions to make a key to check if input is a valid location id. 
  #
  # Returns an array of location ids. 
  def self.in_location
    results_as_objects = []
    StoreLocation.all.each do |location|
      results_as_objects << store_location.id
    end
    return results_as_objects
  end
end

 