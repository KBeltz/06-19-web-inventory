require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

class Yarn
  extend DatabaseMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :brand, :name, :yards, :fiber, :color, :price, :skeins, :weight_id, :store_location_id
  
  # Initializes a new Yarn object
  #
  # yarn_id - Integer id primary key created in the 'yarns' table
  # yarn_name         - String of the yarn name
  # yards             - Integer of the number of yards
  # fiber             - String of the yarn fiber type
  # color             - String of the color name
  # price             - Float of the item price
  # skeins            - Integer of the item quantity
  # weight_id         - Integer id foreign key from weights table
  # store_location_id - Integer id foreign key from the store_locations table
  #
  # Returns a Yarn object
  # def initialize(id, brand = nil, name = nil, yards = 0, fiber = nil, color = nil, price = 0, skeins = 0, weight_id = 1, store_location_id = 1)
  def initialize(yarn_options = {})
    # Example: {"id" => 1, "brand" => "Cascade Yarns", "name" => "Cascade 220", "yards" => 220, "fiber" => "wool", "color" => "violet", "skeins" => 16, "weight_id" => 6, "store_location_id" => 2, "price" => 8.95}
    @id = yarn_options["id"]
    @brand = yarn_options["brand"]
    @name = yarn_options["name"]
    @yards = yarn_options["yards"]
    @fiber = yarn_options["fiber"]
    @color = yarn_options["color"]
    @price = yarn_options["price"]
    @skeins = yarn_options["skeins"]
    @weight_id = yarn_options["weight_id"]
    @store_location_id = yarn_options["store_location_id"] 
  end
end