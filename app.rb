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
require_relative "driver.rb"
require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

#-----------------------------------------------------------------------------

get "/home" do
  erb :"index"
end

get "/manage_inventory" do
  erb :"manage_inventory"
end

get "/location" do
  erb :"manage_location"
end

get "/weight" do
  erb :"manage_weight"
end

get "/search" do
  erb :"search"
end

get "/view" do
  erb :"view"
end
#TODO still need to list yarns so the user can pick which yarn to edit
get "/edit_yarn_name_form/:x" do
  erb :"edit_yarn_name_form"
end

get "/edit_yarn_name" do
  # `params` stores information from the form's submitted information.
  # So right now, `params` is {"x" => "3", "name" => "Marlene"} (for example).
  
  # student = Student.find_as_object(params["x"].to_i)
  # student.name = params["name"]
  # student.save
end

#TODO still need to list yarns so the user can pick which yarn to edit
get "/edit_yarn_quantity_form/:x" do
  erb :"edit_yarn_quantity_form"
end

get "/edit_yarn_quantity" do
  # `params` stores information from the form's submitted information.
  # So right now, `params` is {"x" => "3", "name" => "Marlene"} (for example).
  
  # student = Student.find_as_object(params["x"].to_i)
  # student.name = params["name"]
  # student.save
end

#TODO still need to list yarns so the user can pick which yarn to edit
get "/edit_yarn_location_form/:x" do
  erb :"edit_yarn_location_form"
end

get "/edit_yarn_location" do
  # `params` stores information from the form's submitted information.
  # So right now, `params` is {"x" => "3", "name" => "Marlene"} (for example).
  
  # student = Student.find_as_object(params["x"].to_i)
  # student.name = params["name"]
  # student.save
end

#TODO still need to list yarns so the user can pick which yarn to edit
get "/edit_yarn_price_form/:x" do
  erb :"edit_yarn_price_form"
end

get "/edit_yarn_price" do
  # `params` stores information from the form's submitted information.
  # So right now, `params` is {"x" => "3", "name" => "Marlene"} (for example).
  
  # student = Student.find_as_object(params["x"].to_i)
  # student.name = params["name"]
  # student.save
end



  