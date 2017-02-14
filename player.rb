require_relative 'blackjack'
require_relative 'card'

class Player
  def initialize(name)
    @name = name
    @chips = 500
  end

  def bets
    loop do
      puts "What would you like to bet?"
      bet = gets.chomp
      @chips -= bet
      if @chips <=0
        puts "You do not have enough chips to bet that much!"
      else
        break
      end
    end
  end

  def dealt_hand
    prints "#{@hand[1]}  #{@hand[2]}"
  end

  def total
    tot = 0
    @hand.each do |card|
      tot +=@card.value(card)
    end
    return tot
  end

  def check_blackjack
    return total == 21
  end


  def hit
    @hand += @shoe.shift
  end

  def bust(total)
    total > 21
  end

  def ask_move
    moves = 0
    puts "What would you like to do?"
    puts "1)Hit"
    puts "2) Stand"
    if moves == 0
      puts "3) Double Down"
      puts "4) Split"
    end
    moves += 1
    move = gets.chomp.to_i
    case move
    when 1
      player.hit
      if @shoe.shift == @cut_card
        @cut_card = true
      end
      layout.render
      return true
    when 2
      return false
    when 3
      player.double_down
      return false
    when 4
      player.split
      layout.render
      return true
    else return false
    end
  end

  def settle(game_conclusion)
    gc = game_conclusion
    case gc
    when "lose"
      @bet = nil
      @chips = @chips
    when "player blackjact"
      winnings = @bet * 2.5
      @bet = nil
      @chips += winnings
    when "win"
      @winnings = @bet * 2
      @bet = nil
      @chips += winnings
    end
  end



  # def split_hand
    # if @shoe.shift == @cut_card
    #   @cut_card = true
    # end

  # end
  # def double_down
    # if @shoe.shift == @cut_card
    #   @cut_card = true
    # end


  # end

end
