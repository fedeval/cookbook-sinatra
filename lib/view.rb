require_relative 'recipe'

class View
  def display(recipes_list)
    puts '-- Here are all your recipes --'
    puts ''
    recipes_list.each_with_index do |recipe, index|
      x = recipe.done ? 'x' : ' '
      puts "#{index + 1}. [#{x}] #{recipe.name}: #{recipe.description} ( #{recipe.rating} / 5 ) - Cooking time: #{recipe.prep_time} min."
    end
    puts ''
  end

  def ask_new_recipe
    puts "Which recipe you would like to add?"
    print ">"
    name = gets.chomp
    puts "Please add a description:"
    print ">"
    description = gets.chomp
    puts "Please add a rating (out of 5)"
    print ">"
    rating = gets.chomp.to_i
    puts "Please add a preparation time (minutes)"
    print ">"
    prep_time = gets.chomp.to_i
    return Recipe.new(name, description, rating, prep_time)
  end

  def recipe_to_delete
    puts "Which recipe would you like to delete? (enter index)"
    print ">"
    return gets.chomp.to_i
  end

  def ask_keyword
    puts 'What ingredients would you like a recipe for?'
    print '>'
    keyword = gets.chomp
    puts ''
    puts "Looking for #{keyword} recipes on the Internet.."
    return keyword
  end

  def list_web_results(keyword, results_array)
    puts ''
    results_array.each_with_index { |recipe, index| puts "#{index + 1}. #{recipe.name}" }
    puts ''
    puts 'Which recipe would you like to import? (enter index)'
    print '>'
    index = gets.chomp.to_i
    puts ''
    puts "Importing \"#{results_array[index - 1].name}\" ..."
    return index
  end

  def recipe_done
    puts 'Which recipe have you done? (enter index)'
    print '>'
    return gets.chomp.to_i
  end
end
