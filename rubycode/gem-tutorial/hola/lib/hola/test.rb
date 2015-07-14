class Hola
  class Person < self
    ...
  end
end

class Hola::Person
  ...
end

class Person < Hola
  ...
end
