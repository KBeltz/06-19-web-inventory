require "pry"
require "sinatra"
require "sinatra/reloader"


# empower my program with SQLite
require "sqlite3"

# load/create our database for this program
DATABASE = SQLite3::Database.new("inventory.db")

# Create table to store yarn items
DATABASE.execute("CREATE TABLE IF NOT EXISTS yarns (id INTEGER PRIMARY KEY, brand TEXT, name TEXT, yards INTEGER, fiber TEXT, color TEXT, price DECIMAL (5,2) NOT NULL, skeins INTEGER NOT NULL, weight_id INTEGER NOT NULL, store_location_id INTEGER NOT NULL);")

# Create a table to store weight categories
DATABASE.execute("CREATE TABLE IF NOT EXISTS weights (id INTEGER PRIMARY KEY, weight TEXT);")

# Create a table to store inventory locations
DATABASE.execute("CREATE TABLE IF NOT EXISTS store_locations (id INTEGER PRIMARY KEY, store_location);")

DATABASE.results_as_hash = true

require_relative "yarn.rb"
require_relative "weight.rb"
require_relative "location.rb"
require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

#-----------------------------------------------------------------------------

# main menu for inventory management system
get "/home" do
  erb :"index"
end

# inventory management menu
get "/manage_inventory" do
  erb :"manage_inventory"
end

# edit inventory item form
get "/edit_inventory_item_form" do
  erb :"edit_inventory_item_form"
end

# location management form
get "/location" do
  erb :"manage_location_form"
end

# weight management form
get "/weight" do
  erb :"manage_weight_form"
end

# search menu
get "/search" do
  erb :"search"
end

# Returns a list of all products in the yarns table.
get "/view" do
  erb :"view"
end

# Returns a list of all weights.
get "/weight_list" do
  erb :"weight_list"
end

get "/search_by_weight/:x" do
  @weight_category = Weight.find(params["x"])
  @yarn_in_category = Yarn.where("weight_id", params["x"])
  erb :"search_by_weight"
end

# Returns a list of all locations.
get "/location_list" do
  erb :"location_list"
end

get "/search_by_location/:x" do
  @specific_location = StoreLocation.find(params["x"])
  @yarn_at_store = Yarn.where("store_location_id", params["x"])
  erb :"search_by_location"
end

# form for user to enter information to add product to inventory
get "/add_yarn_form" do
  erb :"add_yarn_form"
end

# Gets parameters from add_yarn_form.
#
# Adds product to yarns table
get "/add_yarn" do
  Yarn.add("brand" => params["brand"], "name" => params["name"], "yards" => params["yards"], "fiber" => params["fiber"], "color" => params["color"], "price" => params["price"], "skeins" => params["skeins"], "weight_id" => params["weight_id"], "store_location_id" => params["store_location_id"])
  
  erb :"success"
end

# Gets parameters from manage_weight_form.
#
# Adds product to weights table
get "/add_weight" do
  Weight.add("weight" => params["weight"])
  
  erb :"success"
end

# Gets parameters from manage_location_form.
#
# Adds product to locations table
get "/add_store_location" do
  StoreLocation.add("store_location" => params["store_location"])
  
  erb :"success"
end

get "/delete_yarn" do
  erb :"delete_yarn"
end

get "/delete_yarn/:x" do
  @specific_yarn = Yarn.find(params["x"])
  @specific_yarn.delete_row
  
  erb :"success"
end

get "/delete_location/:x" do
  @specific_location = StoreLocation.find(params["x"])
  @specific_location.delete_row
  
  erb :"success"
end


get "/delete_weight/:x" do
  @weight_category = Weight.find(params["x"])
  @weight_category.delete_row
  
  erb :"success"
end

#########################################################################
# TODO items below
#########################################################################

# Gets parameters from edit_inventory_item_form, manage_location_form, or 
# the manage_weight_form
#
# Updates the item in the appropriate table of the database
get "/edit_item" do
  #stuff
  #TODO
  erb :"success"
end






