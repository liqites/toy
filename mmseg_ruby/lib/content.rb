  class Content
    attr_accessor :str

    def initialize(str)
      #TODO 这是错误的，不是所有的编码都能force_encodign的
      if str.encoding != 'utf-8'
        @str = String.new(str).force_encoding('utf-8')
      end
    end

    def length
      @str.nil? ? 0 : @str.length
    end

    def get(count = 0, pos = 0)
      res = ""
      count.times.each do |i|
        res<<@str[pos+i]
      end
      res
    end

    def get_token(pos = 0)
      Token.new(@str[pos])
    end

    def get_end?(pos)
      l = str.length
      if pos > l-1
        true
      else 
        false
      end
    end

    def to_a
      @str.chars.to_a
    end
  end