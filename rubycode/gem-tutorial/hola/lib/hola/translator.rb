
  class Translator < Hola
    def initialize(language)
      @language = language
    end

    def hi
      case @language
      when 'sp'
        puts "spanish hi"
      when 'en'
        puts "english hi"
      end
    end
  end
