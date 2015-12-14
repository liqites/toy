p "first"
Const2 = "B"

class C < Object
  Const = "in C"

  p Const

  def upcase(str)
    puts("self.puts")
    return str.upcase
  end

  p Const2
end

C.new.upcase("A")
