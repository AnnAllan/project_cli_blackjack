require_relative 'blackjack'

class Card
  def initialize
    @rank = rank
    @suit = suit
    @value = value
    @deck = decks
  end
 rank_arr = %s(2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A)
 suit_arr = %s(H, D, C, S)
 value_hash =  {rank2: 2, rank3: 3, rank4: 4, rank5: 5, rank6: 6, ranks7: 7, ranks8: 8, rank9: 9, rank10: 10, rankJ: 10, rankQ: 10, rankK: 10, rankA: 11 }

 def decks(rank_arr, suit_arr)
   suit_arr.each do |suit|
     rank_arr.each do |rank|
       card = "#{rank}#{suit}"
       card = Card.new
       deck << card
     end
   end
 end

 def value(card)
   card_name = card.split("").join(", ")
   rank = card_name[0]
   hash_rank = "rank#{rank}"
   return value_hash[hash_rank]
 end


  def ace
  value_hash[rankA] = 1
  end

end
