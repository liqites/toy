class Hola::Foreigner
  def initialize(language)
    @personal = language
  end

  def who?
    case @personal
    when 'en'
      puts "I\'m english"
    when 'sp'
      puts "I\'m spanish"
    end
  end
end
