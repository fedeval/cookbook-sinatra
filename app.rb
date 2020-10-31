# frozen_string_literal: true

require_relative 'database/cookbook.rb'
require_relative 'models/recipe.rb'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, '/database/recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @cookbook = cookbook
  erb :index
end

get '/new' do
  erb :new
end

post '/database/recipes/create' do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/database/recipes/:id/delete' do
  cookbook.remove_recipe(params[:id].to_i + 1)
  redirect '/'
end
