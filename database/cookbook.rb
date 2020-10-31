require 'csv'
require_relative '../models/recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    # Returns all the recipe
    @recipes
  end

  def add_recipe(recipe)
    # Adds a recipe to the cookbook
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    # Removes a recipe from the cookbook
    @recipes.delete_at(recipe_index - 1)
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |file|
      @recipes.each do |recipe|
        file << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done]
      end
    end
  end
end
