class Player
    attr_accessor :name, :chips, :hand, :bet, :insurance_bet, :split_hand,  :split_total, :split_bet
    def initialize
        @name =
        @chips = 500
        @hand = []
        @bet = 0
        @insurance_bet = 0
        @split_hand = []
        @split_total = 0
        @split_bet = 0
    end

    def total
        tot = 0
        num_aces = 0
        if !@hand.nil?
            @hand.each do |card|
                if !card.nil?
                    tot += card.value
                else
                    tot += 0
                end
                if card.value == 11
                    num_aces +=1
                end
            end
        end
        while (tot > 21) && (num_aces > 0) do
            tot -= 10
            num_aces -= 1
        end
        return tot
    end

    def blackjack(player)
        return (player.total == 21) && (@hand.length == 2)
    end

    def bust(player)
        return player.total > 21
    end

end #Player class
