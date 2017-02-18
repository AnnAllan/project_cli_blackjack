# require_relative 'player'
# require_relative 'dealer'
# require_relative 'shoe'
# require_relative 'card'
#
# class Layout
#
# #   def initialize(player, dealer, shoe)
# #     @player_name = player.name
# #     @player = player
# #     @dealer = dealer
# #     @shoe = shoe
# #   end
# #
# #   def self.render(player, dealer, shoe)
# #     cards_left = @shoe.shoe_arr.length
# #     puts "*******************************************************************************"
# #     puts "There are #{cards_left} cards left in the shoe."
# #     puts "There are #{cards_left - Shoe::CUT_LOCATION} cards left in the shoe until the cut card."
# #     puts "The Dealer's total showing is : #{total_showing}."
# #     puts "The Dealer's cards are: #{showing}"
# #     puts "#{@player_name}'s bet is currently: #{@player.bet}."
# #     puts "#{@player_name}'s cards are: #{player_hand}"
# #     puts "#{@player_name}'s total is: #{@player.total}."
# #     puts "#{@player_name} currently has #{@player.chips} chips"
# #     puts "*******************************************************************************"
# #   end
# #
# #   def reveal
# #     cards_left = @shoe.shoe_arr.length
# #     puts "*******************************************************************************"
# #     puts "There are #{cards_left} cards left in the shoe."
# #     puts "There are #{cards_left - Shoe::CUT_LOCATION} cards left in the shoe until the cut card."
# #     puts "The Dealer's total is : #{@dealer.total}."
# #     puts "The Dealer's cards are: #{dealer_hand}"
# #     puts "#{@player_name}'s bet is currently: #{@player.bet}."
# #     puts "#{@player_name}'s cards are: #{player_hand}"
# #     puts "#{@player_name}'s total is: #{@player.total}."
# #     puts "#{@player_name} currently has #{@player.chips} chips"
# #     puts "*******************************************************************************"
# #   end
# #
# #
# #   def player_hand
# #     if !@player.hand[0].nil?
# #       player_hand_string = ""
# #       @player.hand.each do |x|
# #         player_hand_string += "#{x.name}  "
# #       end
# #       return player_hand_string
# #     else
# #        "-- --"
# #     end
# #   end
# #
# #
# #   def showing
# #     if !@dealer.house[0].nil?
# #        "#{@dealer.house[1].name}  &&"
# #     else
# #        "-- --"
# #     end
# #   end
# #
# #   def total_showing
# #     tot = 0
# #     @dealer.house.each do |dealer_card|
# #       if !dealer_card.nil?
# #         tot += dealer_card.value
# #       else
# #         tot += 0
# #       end
# #     end
# #     face_down = @dealer.house[0]
# #     if !face_down.nil?
# #       tot -= face_down.value
# #     else
# #       tot -= 0
# #     end
# #     return tot
# #   end
# #
# #   def dealer_hand
# #     dealer_hand_string = ""
# #     @dealer.house.each do |x|
# #       dealer_hand_string += "#{x.name}  "
# #     end
# #     return dealer_hand_string
# #   end
# #
# # end
