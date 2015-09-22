
  class Token
    attr_accessor :char

    def initialize(char)
      @char = char
    end

    def type
      TokenType.recognize(@char)
    end
  end