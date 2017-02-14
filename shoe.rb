require_relative

class Shoe
  def initialize
    @shoe = create_shoe
    @cut_card = "%%"
  end

  def create_shoe
    shoe_arr = []
    8.times do
      shoe_arr << @card.decks
    end
    shoe_shuffled = shoe_arr.shuffle
    shoe_ready = shoe_shuffled.insert(309, @cut_card)
    return shoe_ready
  end

  def cut_cards
    @shoe = []
    @shoe = Shoe.new
  end

  def cards_left(shoe)
    cl = 416 - shoe.length
    return cl
  end

  def cards_to_cut(cl)
    cc = cl - 104
    return cc
  end

end
