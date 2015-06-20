require_relative "database_methods.rb"
require_relative "database_instance_methods.rb"

class Weight
  extend DatabaseMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :weight
  
  # Initializes a new Weight object
  #
  # id - Integer id primary key created in the 'weights' table
  # weight  - String of yarn weight type
  #
  # Returns a Weight object
  def initialize(weight_options = {})
    @id = weight_options["id"]
    @weight = weight_options["weight"]
  end

  def self.in_category
    results_as_objects = []
    Weight.all.each do |category|
      results_as_objects << category.id
    end
    return results_as_objects
  end
end