require_relative 'player'
require_relative 'dealer'
require_relative 'shoe'
require_relative 'layout'

class Game
  def initialize
    dealer = Dealer.new
    player_name = dealer.greeting
    player = Player.new(player_name)
    dealer.instructions
    layout = Layout.new
    shoe = Shoe.new
  end

  def play
    play = true
    until play == false
      def hand
        layout.render
        player.bet
        dealer.deal
        layout.render
        if dealer.check_blackjack
          puts "The Dealer has a blackjack.  House wins."
          plaeyer.settle(lose)
          break
        elsif player.check_blackjack
          puts "You have a blackjack.  You win!"
          player.settle(player_blackjack)
          break
        end
        loop do
          if !player.ask_move?
            break
          end
        end
        if player.bust
          puts "You have busted."
          player.settle(lose)
        end
        dealer.reveal
        layout.render
        until dealer.dealer_total >= 17 do
          dealer.hit
          layout.render
          if dealer.dealer_total > 21
            player.settle(win)
            puts "Dealer busted, you win."
          end
        end
        if player.win?
          player.settle(win)
          puts "You win"
        else
          plater.settle(lose)
          puts "Dealer wins"
        end
      puts "Would you like to play another hand?"
      puts "1) Yes"
      puts "2) No"
      if gets.chomp.to_i == 2
        play = false
      else
        if @cut_card == true
          @shoe = Shoe.new
        end
        play = true

      end
      end
    end
  end

end

g = Game.new
g.play
