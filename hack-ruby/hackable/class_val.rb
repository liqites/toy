class A
  @@a = 1
  def add_a
    puts @@a
    @@a = @@a + 1
  end
end

a = A.new
b = A.new

a.add_a
b.add_a

class B < A
  @@a = 2
end

c = B.new

c.add_a
c.add_a
