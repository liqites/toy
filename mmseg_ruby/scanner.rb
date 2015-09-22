# encoding: utf-8

require_relative 'lib/token_type'
require_relative 'lib/token'
require_relative 'lib/content'
require_relative 'lib/lexicon'
require 'logging'
require 'colorize'

class Scanner
  @@lexicon = nil

  @@lexicon = Lexicon.instance
  @@lexicon.load("../wordlib_new.txt")

  def self.lexicon
    @@lexicon
  end

  def self.simple_maximum_match content
    #lexicon = Lexicon.instance
    #lexicon.load("../wordlib_new.txt")

    scaned_content = []

    current_pos = 0

    #是否到文章的末尾

    word = ""
    length = content.length
    while !content.get_end?(current_pos)
      token = content.get_token(current_pos)

      #puts "next char:#{token.char}".blue
      # 这里做了什么？
      # before_word = word 不是新建变量
      # 下面才是
      before_word = String.new(word)

      # 这里要注意，有错误!
      # 什么错误？我去，昨天写的，居然忘记了。
      #
      # 如果是第一个词就没有找到呢？
      if token.type == TokenType::SYMBOL
        if word.length > 0
          scaned_content << word << token.char
          word=""
        else
          scaned_content << token.char
        end
        current_pos= current_pos + 1
        next
      end

      word << token.char
      if before_word.length == 0
        before_word = word
      end

      if word.empty?
      end
      result = lexicon.find(word)
      str = result.to_s

      #puts "------------------------------------".green
      #puts "search:#{word},find #{str}".green
      #puts "------------------------------------".green

      # TODO 这里是有错误的，如果中间一直出现查找的情况，且
      # before_word和word 为空格的情况下
      # 会出现死循环
      if result.count == 0
        scaned_content << before_word
        if before_word.length == word.length
          current_pos = current_pos + 1
        end
        word = ""
        next
      end

      current_pos = current_pos + 1

      if content.get_end?(current_pos)
        scaned_content << word
      end

    end

    puts "=============".yellow
    puts "#{content.str}".yellow
    puts "#{scaned_content.to_s}".yellow
    puts "=============".yellow
    scaned_content
  end

  def self.complex_maximum_macth(content)
    # 第一步，找到所有可能的三词组合
    # 第二步，找到长度最长的组合
    # 第三步，去除第一个字，认为是最有个能的词语
    # 第四部，重复直到文本结束
    # 注意！非字符符号！

    scaned_content = []
    current_pos = 0
    while !content.get_end?(current_pos)

      token = content.get_token(current_pos)


      if token.type == TokenType::SYMBOL
        scaned_content << token.char
        current_pos = current_pos + 1
        next
      end

      chunks = all_wordchunks(content,current_pos)
      # 去除最长的chunks的头
      if chunks.length == 0
        scaned_content << token.char
        current_pos = current_pos + 1
      else
        max = []
        chunks.each{|c|
          l = c.join("")
          max = (l.length >= max.length) ? c : max
        }
        scaned_content << max.first
        current_pos = current_pos + max.first.length
      end
    end

    puts "=============".yellow
    puts "#{content.str}".yellow
    puts "#{scaned_content.to_s}".yellow
    puts "=============".yellow
    scaned_content
  end

  # 找到词组数组
  # 参数
  # @content:content对象
  # @positon:查找的起始位置
  # @count:词组中词语的个数，默认3
  # @return:所有可能的词组数组
  # [
  #   ["","",""]
  # ]
  def self.all_wordchunks(content,position,count = 3)
    current_pos = position
    heads = all_match(content,position)

    wordchunk = []

    heads.each do |he|
      h = he.first
      chunks = []
      chunks << h

      res = ""
      finished = true
      (count - 1).times.each do |i|
        result = max_match(content,current_pos+h.length + res.length)
        if result.length > 0
          res << result
          chunks << result
        else
          finished = false
          break
        end
      end

      if finished
        wordchunk << chunks
      end
    end
    puts "--------------"
    puts heads.to_s
    puts wordchunk.to_s
    puts "--------------"
    wordchunk
  end

  # 找到文本中，从position开始的最长字符匹配
  # @content: 文本
  # @position: 起始位置
  # return
  # String
  def self.max_match(content,position)
    current_pos = position
    str =  ""
    word = ""
    while !content.get_end?(current_pos)
      token = content.get_token(current_pos)
      if token.type == TokenType::SYMBOL
        return str
      end
      word << token.char
      result = lexicon.search(word)
      if result.length > 0
        str << token.char
      else
        break
      end
      current_pos = current_pos + 1
    end
    str
  end


  def self.all_match(content,position)
    current_pos = position
    heads = []
    str = ""
    while !content.get_end?(current_pos)
      token = content.get_token(current_pos)
      if token.type == TokenType::SYMBOL
        break
      end

      str <<token.char
      res = lexicon.find(str)
      #puts res.to_s
      if res.count > 0 #&& res.select{|r| r.length == str.length}.count > 0
        heads << res.select{|r| r.length == str.length}
      else
        break
      end
      current_pos = current_pos + 1
    end
    heads
  end
end