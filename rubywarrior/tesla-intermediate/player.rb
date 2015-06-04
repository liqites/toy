require 'actionable'
require 'sensable'
require 'determination'
require 'json'

# coding: utf-8
class Player
  attr_accessor :directions,:warrior,:is_escape

  include Actionable
  include Sensable
  include Determination

  def initialize()
    @directions = [:forward,:backward,:right,:left]
  end

  def play_turn(warrior)
    @warrior = warrior
    space = find_target
    puts "@@@@@@#{space},#{@warrior.direction_of space}" if space
    dir = space.nil? ? @warrior.direction_of_stairs : (@warrior.direction_of space)
    situation,direction = current_situation(space)
    dir = direction.nil? ? dir : direction
    case situation
    when "bad"
      puts "bad--->>>escape!"
      escape!
    when "rest"
      puts "rest--->>>rest!"
      rest!
    when "rescue"
      puts "rescue--->>>#{dir}"
      rescue!(dir)
    when "attack"
      puts "attak--->>>#{dir}"
      attack!(dir)
    when "bing"
      puts "bing--->>>#{dir}"
      bind!(dir)
    when "good"
      puts "good--->>>#{dir}"
      forward!(dir)
    end
  end
end
