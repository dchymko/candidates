# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require 'byebug'
require_relative './candidates'
require_relative './filters'

## Your test code can go here


#binding.pry
# pp experienced?(@candidates[2])
# puts
# pp find(10)
# puts
# pp qualified_candidates
# puts
# pp ordered_by_qualifications(@candidates)

def menu
  puts "Please make a selection"
  puts
  puts "(find)      Find first candidate"
  puts "(all)       Show all candidates"
  puts "(qualified) Show only qualified candidates"
  puts "(quit)      Quit program"
  
end

def process(option)  
  if option.include? "find"
    pp find(getIdFromString(option))
  elsif option == "all"
    pp ordered_by_qualifications(@candidates)
  elsif option == "qualified"
    pp qualified_candidates  
  elsif option == "quit"
    reset
  else
    puts "I don't know what that is"
  end
end

loop do
  menu
  option = gets.chomp
  break if option == "quit"
  process(option)
end