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

# Returns a list of all products.
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

# Returns a list of all weights.
get "/weight_list" do
  erb :"weight_list"
end

# Returns a list of all locations.
get "/location_list" do
  erb :"location_list"
end

get "/search_by_location" do
  erb :"search_by_location"
  # doesn't quite work. Returns a blank screen.
end

# form for user to enter information to add product to inventory
get "/add_yarn_form" do
  erb :"add_yarn_form"
end

get "/add_yarn" do
  Yarn.add("brand" => brand, "name" => name, "yards" => yards, "fiber" => fiber, "color" => color, "price" => price, "skeins" => skeins, "weight_id" => weight_id, "store_location_id" => store_location_id)
end

get "/delete_yarn_form" do
  erb :delete_yarn_form
end

get "/delete_yarn" do
  Yarn.delete_row
end


##########################################################################
# Begin HELP app
##########################################################################

# Recieves product params from add product form.
#
# Adds product to products table as long as "name" is not empty.
# if name is empty, asks them to try again.
#
# .add adds to database and to Product object.
#
# Returns success page if name is not empty.
get "/save_product" do
  if params["name"].empty?
    # Unsuccessful edit page.
    erb :"try_again"
  else 
    Product.add({"name" => params["name"], "brand" => params["brand"], "category_id" => params["category_id"].to_i, "quantity" => params["quantity"].to_i, "location_id" => params["location_id"].to_i})
    # Successful edit page.
    erb :"product_added"
  end
end
# edit_products path displays an edit form for product.
get "/edit_products" do
  erb :"products" 
end
# Recieves params from edit_products/products page.
# If fields aren't empty, save new value in object.
get "/edit_save" do
  @product_instance = Product.find(params["id"])
  if !params["name"].empty?
    @product_instance.name = params["name"]
  end
  if !params["brand"].empty?
    @product_instance.brand = params["brand"]
  end
  if !params["category_id"].empty?
    @product_instance.category_id = params["category_id"].to_i
  end
  if !params["quantity"].empty?
    @product_instance.quantity = params["quantity"].to_i
  end
  if !params["location_id"].empty?
    @product_instance.location_id = params["location_id"].to_i
  end
  # Save product in database
  @product_instance.save
  # Success page for editing product
  erb :edit_success
  
end

 
get "/edit_store" do
  erb :"edit_store" # where the edit store form lives for stores.
end
 
get "/save_store" do
  @location_instance = Location.find(params["id"])
  if !params["name"].empty?
    @location_instance.name = params["name"]
  end
  if !params["address"].empty?
    @location_instance.address = params["address"]
  end
  @location_instance.save
  erb :"edit_store_success"
  
end
# Returns a param id for location chosen
# Creates location instance by param ID recieved from products_location.
# Returns a list of products in that location.
get "/see_location/:x" do
  # `params` stores information from BOTH the path (:x) and from the
  # form's submitted information. So right now,
  # `params` is {"x" => "3", "name" => "Marlene"}
  @location_instance = Location.find(params["x"])
  @products_in_location = Product.where("location_id", params["x"])
  erb :"see_products_in_location"
end
# Returns a param id for category chosen.
# Creates category instance by param ID recieved from products_category.
# Returns a list of products in that category.
get "/see_category/:x" do
  @category_instance = Category.find(params["x"])
  @products_in_category = Product.where("category_id", params["x"])
  erb :"see_products_in_category"
end




  