class Card
    attr_reader :value, :rank, :suit, :name, :shoe_arr

    def initialize(rank, suit, value)
        @rank = rank
        @suit = suit
        @value = value
        @name = "#{rank}#{suit}"
    end

end
