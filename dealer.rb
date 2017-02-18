# require_relative 'player'
# require_relative 'card'
# require_relative 'shoe'
#
# class Dealer
#   attr_reader :name,  :house
#   attr_accessor :total, :hand, :house
#   def initialize(shoe, player)
#     @name = "Conrad"
#     @shoe = shoe
#     @player = player
#     @house = []
#     @total = 0
#   end
#
#   # def self.greeting
#   #   puts "Hello, I'm Conrad and I will be your dealer.  What is your name?"
#   #   #return gets.chomp
#   # end
#   #
#   def self.instructions(player)
#     # puts "Welcome, #{player.name}.  You will begin the game with $#{player.chips} in chips which you can bet in $1 increments.  Your goal is for your cards to total as close to 21 as you can without going over or \"bust\".  To start the game you will make your first round of bets and be dealt two cards face up and I will be dealt two cards with one face up.  If I am dealt 21, I win instantly.  If you are dealt 21 and I am not, you win instantly and receive 1.5 times your bet.  The dealer will stand on a hard 17.  Aces are worth either 1 or 11, whichever is more adventageous. The shoe consists of 8 decks that will be reshuffled at the end of the hand in which the cut card is drawn approximately three-quarters of the way in. Let's begin."
#   end
#
#   def deal
#     2.times do
#       @house << @shoe.shoe_arr.shift
#       @total += @house[-1].value
#       @player.hand << @shoe.shoe_arr.shift
#       @player.total += @player.hand[-1].value
#     end
#   end
#
#   def check_blackjack
#     return @total == 21
#   end
#
#   def hit
#     @house << @shoe.shoe_arr.shift
#     @total += @house[-1].value
#   end
#
#   def bust
#     @total > 21
#   end
#
# end
