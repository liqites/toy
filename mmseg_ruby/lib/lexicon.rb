require 'singleton'

  class Lexicon
    include Singleton

    attr_accessor :file, :lexicon

    # load lexicon file
    # and sort
    def load(file)
      if @file.nil?
        @file = file
      end

      @lexicon = []

      #TODO sort
      File.open(file, "r").each_line do |line|
        #line.force_encoding('utf-8')
        @lexicon << line.gsub("\n", "")
      end
    end

    #
    def search(word)
      a = @lexicon.select { |l|
       l.start_with? word
      }
      #puts "==>result,#{a.to_s}"
      a
    end

    def find(word)
      a = @lexicon.select { |l|
       l == word
      }
      a
    end
  end