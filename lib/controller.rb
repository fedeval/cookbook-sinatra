require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative 'view'
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'scraper'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # List all recipes
    @view.display(@cookbook.all)
  end

  def create
    # Create a new recipe
    new_recipe = @view.ask_new_recipe
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # Destroy an exsiting recipe
    list
    recipe_index = @view.recipe_to_delete
    @cookbook.remove_recipe(recipe_index)
  end

  def web_search
    # Search for recipes on the web and add them to the cookbook
    keyword = @view.ask_keyword
    recipes = ScrapeAllrecipesService.call(keyword)
    index = @view.list_web_results(keyword, recipes)
    @cookbook.add_recipe(recipes[index - 1])
  end

  def done
    # Mark a recipe as done
    list
    recipe_index = @view.recipe_done
    @cookbook.all[recipe_index - 1].mark_as_done
  end
end
