# require_relative 'card'
#
# class Shoe
#   CUT_LOCATION = 104
#   attr_reader :shoe_arr
#   attr_accessor :shoe
#   def initialize
#
#     puts "Creating new shoe"
#   end
#
#   def create_shoe
#     shoe_cards = []
#     8.times do
#       Card.suit_arr.each do |suit|
#         Card.rank_hash.each do |rank, value|
#           card = Card.new(rank, suit, value)
#           shoe_cards << card
#         end
#       end
#     end
#     shoe_ready = shoe_cards.shuffle
#     return shoe_ready
#   end
#
# end
