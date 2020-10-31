# frozen_string_literal: true

require_relative 'database/cookbook.rb'
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

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
