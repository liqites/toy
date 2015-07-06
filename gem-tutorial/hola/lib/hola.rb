class Hola
  def self.hi(language = "en")
    translator = Translator.new(language)
    translator.hi
    fore = Foreigner.new(language)
    fore.who?
	end
end

require 'hola/translator.rb'
require 'hola/foreigner.rb'
