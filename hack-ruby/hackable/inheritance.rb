class Cls
  def test
    puts "Cls#test"
  end
end

module Mod
  def test
    puts "Mod#test"
  end
end

module Mod2
  def test
    puts "Mod2#test"
  end
end

class Modcls < Cls
  include Mod2
  include Mod
end

c = Modcls.new
c.test # puts what?
