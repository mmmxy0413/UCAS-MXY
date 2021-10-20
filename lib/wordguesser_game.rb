class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :word_with_guesses
  attr_accessor :wrong_guesses
  attr_accessor :wrong_guesses_list
  attr_accessor :correct_guesses
  attr_accessor :wrong_times
  attr_accessor :check_win_or_lose
  attr_accessor :pos_1
  attr_accessor :pos_2
  attr_accessor :pos_3

  def initialize(word)
    @word = word
    @guesses = "" #当前猜的字母正确
    @wrong_guesses = "" #当前猜的字母错误
    @wrong_guesses_list = "" #猜错的字母 zxf
    @correct_guesses = "" #猜对的字母 ba
    @word_with_guesses = "" #当前猜的情况 ba-a-a
    @wrong_times = 0
    @check_win_or_lose = :play
    for i in 1..word.length
	    word_with_guesses.concat('-')
    end                                
  end

  def isAlpha(a)
    if a != nil
      if (a >= 'a' && a <= 'z') || (a >= 'A' && a<= 'Z')
        return true
      else 
        return false
      end
    end
  end
  
  def guess(alpha)
    #context 'invalid'
    if alpha == ''
      raise ArgumentError
    elsif !isAlpha(alpha)
      raise ArgumentError
    elsif alpha == nil
      raise ArgumentError
    elsif alpha >= 'A' && alpha <= 'Z'
      puts 'is case insensitive'
      return false
    else
      @pos_1 = word.index(alpha)
      @pos_2 = word_with_guesses.index(alpha)
      
      #对且不重复
      if pos_1 != nil && pos_2 == nil
        @guesses = alpha
        @correct_guesses.concat(alpha)
        for i in 0..word.length-1
          if word[i] == alpha
            @word_with_guesses[i] = alpha
          end
        end
        if word_with_guesses.index('-') == nil
          @check_win_or_lose = :win
        end
      #对且重复
      elsif pos_1 != nil && pos_2 != nil
        return false
      #错
      else
        @wrong_guesses = alpha
        @pos_3 = wrong_guesses_list.index(alpha) #标识alpha有没有在错误列表里
        @wrong_times = @wrong_times + 1
        #错且不重复
        if pos_3 == nil
          @wrong_guesses_list.concat(alpha)
          if wrong_times >= 7
            @check_win_or_lose = :lose
          end
          return true
        #错且重复
        else 
          return false
        end
      end
    end
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
