module Determination
  SITUATION=["bad","attack","rescue","rest","good"]
    
  # 这个方法太臃肿了，后面要想办法修改掉
	def current_situation target
    situation = ""
    direction = :forward
    res = look_around
    enemies = res.select{|r| r.enemy? }

    if low_health?
      situation = "bad"
    end

    return situation,direction unless situation == ""

    #if enemy_around? && !low_health?
    #  situation = "attack"
    #  direction = @warrior.direction_of(enemies.first)
    #end
    # 根据target来进行判断
    # 如果是ticking captive
    if target 
      target_dir = @warrior.direction_of target
      facing = @warrior.feel(target_dir)
      
      if need_rest?
        return "rest"
      end
    
      if target.ticking?
        if facing.enemy? && !low_health?
          return "attack",target_dir
        end
      
        if facing.captive?
          return "rescue",target_dir
        end
      
        if facing.empty?
          return "good",target_dir
        end
      end
    end

    if !enemy_around? && need_rest?
      return "rest"
    end
    
    if enemy_around?
      return "attack"
    end

    captives = res.select{|r| r.captive?}
    if captives.length > 0
      situation = "rescue"
      direction = @warrior.direction_of(captives.first)
    end

    return situation,direction unless situation == ""
    return "good"
  end
end