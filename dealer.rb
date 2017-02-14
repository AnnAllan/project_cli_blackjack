require_relative 'blackjack'
require_relative 'player'
require_relative 'card'
require_relative 'shoe'

class Dealer
  def initialize
    @name = "Conrad"
  end

  def greeting
    puts "Hello, I'm Conrad and I will be your dealer.  What is your name?"
    return gets.chomp
  end

  def instructions
    puts "Welcome, #{@player.name}.  You will begin the game with $#{@player.chips} in chips which you can bet in $1 increments.  Your goal is for your cards to total as close to 21 as you can without going over or \"buts\".  To start the game you will make your first round of best and be dealt two cards face up and I will be dealt two cards with one face up.  If I am dealt 21, I win instantly.  If you are dealt 21 and I am not you win instantly and receive 1.5 times your bet.  If you are dealt two cards of the same value you have the option to split your bet.  At this time you also have the option to double down and only recieve one additional card.  The dealer will stand on a hard 17.  Aces are worth either 1 or 11, whichever is more adventageous. The shoe consists of 8 decks that will be reshuffled at the end of the hand in which the cut card is drawn approximately three-quarters of the way in. Let's begin."
  end

  def deal
    2.times do
      @house += @shoe.shift
      @hand += @shoe.shift
      if @shoe.shift == @cut_card
        @cut_card = true
      end
    end
  end

  def showing
    print "#{@house[1]}  **"
  end

  def dealer_total
    tot = 0
    @house.each do |card|
      tot +=@card.value(card)
    end
    return tot
  end

  def check_blackjack
    return dealer_total == 21
  end

  def hit
    @house += @shoe.shift
    if @shoe.shift == @cut_card
      @cut_card = true
    end
  end

  def bust(dealer_total)
    dealer_total > 21
  end

  def reveal
    print "#{@house[1]}  #{@house[0]}"
  end



end
