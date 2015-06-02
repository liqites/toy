require 'actionable'
require 'sensable'
require 'json'

# coding: utf-8
class Player
  attr_accessor :directions,:warrior,:is_escape

  include Actionable
  include Sensable

  def initialize()
    @directions = [:forward,:backward,:right,:left]
  end

  def play_turn(warrior)
    @warrior = warrior
    space = find_target
    puts "@@@@@@#{space}"
    dir = space.nil? ? @warrior.direction_of_stairs : (@warrior.direction_of space)

    situation,direction = current_situation
    case situation
    when "bad"
      puts "@@@@@@bad"
      escape!
    when "rest"
      puts "@@@@@@rest"
      rest!
    when "rescue"
      puts "@@@@@@rescue,#{direction}"
      rescue!(direction)
    when "attack"
      puts "@@@@@@attak,#{direction}"
      attack!(direction)
    when "good"
      puts "@@@@@@good,#{dir}"
      forward!(dir)
    end
  end
end
