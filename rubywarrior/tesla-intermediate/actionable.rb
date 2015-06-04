module Actionable
	def rescue!(direction = :forward)
		if @warrior.feel(direction).empty?
      @warrior.walk!(direction)
    else
      @warrior.rescue!(direction)
    end
	end
  
	def forward!(direction = :forward)
    e,c = listen_all
    if ((@warrior.feel(direction).stairs? && ((e+c).length > 0))) || @warrior.feel(direction).wall?
      puts "@@@@@@week_direction"
      space = week_direction
      puts "#{space},#{@warrior.direction_of space}"
      @warrior.walk!(@warrior.direction_of(space))
    else
      @warrior.walk!(direction)
    end
	end

	def attack!(direction = :forward)
    if @warrior.feel(direction).empty?
      @warrior.walk!(direction)
    else
      @warrior.attack!(direction)
    end
  end

	def escape!
    puts "#############escape!##########"
    dir = week_direction
    direction = @warrior.direction_of(dir)
    if dir.captive?
      @warrior.rescue!(direction)
    end

    if dir.empty?
      @warrior.walk!(direction)
      @is_escape = true
    end

    if dir.enemy?
      @warrior.attack!(direction)
    end
  end

  def rest!
    puts "#############{@is_escape}##########"
    @warrior.rest!
  end
  
  def bind!(direction = :forward)
    @warrior.bind!(direction)
  end
end