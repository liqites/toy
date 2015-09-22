require_relative 'symbol_cn'

  class TokenType
    SYMBOL = 0
    WORD = 1

    def self.recognize(token)
      if SymbolCn.instance.lib.include? token
        return SYMBOL
      else
        return WORD
      end
    end
  end