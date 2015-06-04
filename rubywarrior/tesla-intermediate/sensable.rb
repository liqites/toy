# coding: utf-8
module Sensable
  def get_next_direction(direction)
    res = look_up(@directions - [direction])
    @warrior.direction_of(res.select{|r| !r.wall?})
  end

  # week direction of current place
  # 1.captive
  # 2.empty
  # 3.enemy
  def week_direction
    res = look_around
    captives = res.select{|r| r.captive?}
    holes = res.select{|r| (r.empty? && !r.stairs?)}
    enemies = res.select{|r| r.enemy?}

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

   # look around spaces
  def look_around
    look_up(@directions)
  end

   # look for specific directions
  def look_up(directions)
    res = []
    directions.each{|d|
      space = @warrior.feel(d)
      res << space
    }
    res
  end

  # listen all spaces on the map
  def listen_all
    spaces = @warrior.listen
    enemies = spaces.select{|s| s.enemy? }
    captives = spaces.select{|s| s.captive?}
    return enemies,captives
  end

  # find next target
  def find_target
    enemies,captives = listen_all
    cs = captives.select{|c|c.ticking?}
    return (cs+(captives-cs)).first
  end

  def low_health?
     (around_enemy_count * 3) >= @warrior.health
  end

  def need_rest?
    @warrior.health < 7
  end

  def enemy_around?
    look_around.select{|a|a.enemy?}.length > 0
  end

  def face_enemy?
    @warrior.feel.enemy?
  end
  
  #enemy counter
  def around_enemy_count
     look_around.select{|s|s.enemy?}.length
  end
end
