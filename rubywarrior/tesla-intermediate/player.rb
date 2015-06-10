require 'json'

# coding: utf-8
class Player
  attr_accessor :directions,:warrior,:is_escape,:binded_dir

  MAX_HEALTH = 20
  ATTACK = 5
  DAMAGE = 3

  def initialize(*args)
    @directions = [:forward,:backward,:right,:left]
  end

  # player turn
  def play_turn(warrior)
    if @warrior.nil?
      @warrior = warrior
    end
    
    action,direction,spaces = get_action
    case action
      when 'walk'
        @warrior.walk!(direction)
        @binded_dir = []
      when 'attack'
        @warrior.attack!(direction)
      when 'rescue'
        @warrior.rescue!(direction)  
      when 'bind'
        bind(spaces)
      when 'rest'
        rest!
      else
    end
  end
  
  #-------------
  # get_action
  # return action and direction determined by current situaton
  #-------------
  def get_action
    target = current_target
    target_dir = @warrior.direction_of target
    
    # target id nil
    if target.nil?
      return "walk",@warrior.direction_of_stairs
    end
    
    if low_health?
      return "rest"
    end
    
    if need_rest? && !target.ticking?
      return "rest"
    end
    
    # if there is something ticking,
    # it's emergency
    if target.ticking?
      if threatened_enemies.length > 1
        enemies_not_facing = threatened_enemies.select{|e|
          @warrior.direction_of(e) != target_dir
        }
        return 'bind',nil,enemies_not_facing
      end
      
      facing = @warrior.feel(target_dir)
      if facing.enemy?
        return 'attack',target_dir
      end
      
      if facing.captive?
        return 'rescue',targer_dir
      end
      
      if facing.empty?
        return 'walk',target_dir
      end
    end
    
    # nothing else
    space = spaces_around.select{|s| !s.empty?}.first
    if space.enemy?
      return 'attack',@warrior.direction_of(space)
    end
    
    if space.captive?
      return 'rescue',@warrior.direction_of(space)
    end
    return 'walk',target_dir
  end
  
  #----------------------------------------------
  #actionable
  #-------------
  # rest!
  # get the action 'rest',
  # choose to escape! or rest!
  #-------------
  def rest!
    if threatened_enemies.length > 0
      escape!
    else
      @warrior.rest!
    end
  end
  
  #-------------
  # bind! Array(Space)
  # bind Spaces
  #-------------
  def bind(spaces)
    dir = @warrior.direction_of(spaces.first)
    @binded_dir << dir
    @warrior.bind!(dir)
  end
  
  #-------------
  # escape!
  # current situation is bad, need to escape
  #-------------
  def escape!
    space = week_space
    direction = @warrior.direction_of(space)
    if space.captive?
      @warrior.rescue!(direction)
    end

    if space.empty?
      @warrior.walk!(direction)
    end

    if space.enemy?
      @warrior.attack!(direction)
    end
  end
  
  #----------------------------------------------
  #sensable
  
  #-------------
  # low_health?
  # return true if total damage
  # cased by threatened(unbinded) enemies
  # is higher than current health 
  #-------------
  def low_health?
    threatened_enemies.length * DAMAGE >= @warrior.health
  end
  
  #-------------
  # need_rest?
  # true if health < MAX_HEALTH
  #-------------
  def need_rest?
    @warrior.health < MAX_HEALTH
  end
  
  #----------------------------------------------
  # helper methods
  
  #-------------
  # week_space
  # current situation is bad
  # should find out the week space
  # to escape
  # return space
  #-------------
  def week_space
    spaces = spaces_around
    captives = spaces.select{|r| r.captive?}
    holes = spaces.select{|r| (r.empty? && !r.stairs?)}
    enemies = spaces.select{|r| r.enemy?}

    if captives.length > 0
      return captives.first
    end

    if holes.length > 0
      return holes.first
    end

    if enemies.length > 0
      return enemies.first
    end

    return res.first
  end
  
  #-------------
  # threatened_enemies
  # return enemy space that is 
  # unbinded
  #-------------
  def threatened_enemies
    spaces_around.select{|s|
      s.enemy? && !@binded_dir.include?(@warrior.direction_of(s))
    }
  end

  #-------------
  # spaces_around
  # return all the spaces 
  # around player,nil if nothing
  #-------------
  def spaces_around(direction = @directions)
    spaces = []
    directions.each{|d|
      spaces << @warrior.feel(d)
    }
    spaces
  end
  
  #-------------
  # current_target
  # return current target space, nil if nothing to be down
  #-------------
  def current_target
    enemies,captives = listen_all
    cs = captives.select{|c|c.ticking?}
    return (cs+(captives-cs)+enemies).first
  end
  
  #-------------
  # listen_all
  # return all spaces by kind
  #-------------
  def listen_all
    spaces = @warrior.listen
    return spaces.select{|s| s.enemy?},spaces.select{|s| s.captive?}
  end
end