require_relative 'player'
require_relative 'dealer'
require_relative 'shoe'

class Layout
  def initialize
    @showing = dealer.showing
    @house = dealer.hand
    @bet = player.bets
    @hand = player.hand
    @total = player.total
    @chips = player.chips
    @split_bet = player.bet
    @split_hand = player.split_hand
    @shoe = shoe.cards_left
    @cut = shoe.cards_to_cut
  end

  def render
    puts "The Dealer's total showing is : #{@showing}."
    puts "The Dealer's cards are: #{@house}"
    puts "#{@player.name}'s bet is currently: #{@bet}."
    puts "#{@player.name}'s cars are: #{@hand}"
    puts "#{@player.name}'s total is: #{@total}."
    puts "#{@player.name} currently has #{@chips} chips"
  end

end
