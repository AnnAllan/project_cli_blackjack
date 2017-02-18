require_relative 'player'
require_relative 'card'

class Game
    def initialize
        @shoe = create_shoe
        @players = []
        @dealer = Player.new
        @dealer.name = "Conrad"
        ai = false
    end

    def play
    #set up players
        print "Hello, I'm #{@dealer.name} and I will be your dealer.  How many players will there be? (Please enter a number between 1 and 5.) :  "
        num_players = 1
        # loop do
        #     num_players = gets.chomp.to_i
        #     if  num_players.between?(1, 5)
        #         break
        #     else
                    # puts "-----------------------------------------------------"
        #         print "Your input was not valid.  Please enter a digit between  1 and 5:  "
        #     end
        # end

        num_players.times do |x|
            puts "-----------------------------------------------------"
            print "Please enter the name of Player #{x + 1}:  "
            @players[x] = Player.new
            @players[x].name = "Ann"
        end
        puts "-----------------------------------------------------"
        print "Would you like to play with a computer opponent as well? (Please enter 1 for Yes or any other key for No:  "
        # if gets.chomp == 1
            @comp= Player.new
            ai = true
            @comp.name = "Ben"
            puts "-----------------------------------------------------"
            print "Hi, I'm #{@comp.name}.  I will be sitting to the left of the human players."
        # end
    #instructions
        puts "Welcome.  For detailed instructions on the about the game and betting please visit www.bicycle.com/how-to-play/blackjack. You will begin the game with $#{@players[0].chips} in chips which you can bet in $1 increments.  You may bet in increments of $1 between $20 and $500. The shoe consists of 8 decks that will be reshuffled at the end of the hand in which the cut card is drawn approximately three-quarters of the way in. Let's begin."

    #Game loop
        game_over = false
        while !game_over do
            render(false, num_players, ai)
            bets(num_players, ai)
            player_done = false
            comp_done = false
            dealer_done = false
            deal(num_players, ai)
            render(false, num_players, ai)
            if @dealer.hand[0].value == 11
                insurance(num_players, ai)
            end
            if @dealer.hand[0].value >= 10
                if @dealer.blackjack(@dealer)
                    render(true, num_players, ai)
                    dealer_naturals(num_players, ai)
                    player_done = true
                    comp_done = true
                    dealer_done = true
                else
                    puts "-----------------------------------------------------"
                    puts "Dealer does not have a blackjack."
                end
            end
            num_players.times do |x|
                if @players[x].blackjack(@players[x])
                    puts "-----------------------------------------------------"
                    puts "#{@players[x].name}, you have a natural blackjack.  You win 1.5 times your bet instantly."
                    @players[x].chips += (@players[x].bet * 1.5).to_i
                    render(false, num_players, ai)
                end
            end
            if ai
                if @comp.blackjack(@comp)
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name}, you have a natural blackjack.  You win 1.5 times your bet instantly."
                    @comp.chips += (@comp.bet * 1.5).to_i
                    render(false, num_players, ai)
                end
            end

        #player turns
            if !player_done
                num_players.times do |x|
                     hand_state = check_split_double_down(num_players, ai)
                     case hand_state
                     when 1
                         puts "-----------------------------------------------------"
                         puts "#{@players[x].name}, you  receive one card."
                         render(false, num_players, ai)
                     when 2
                         puts "-----------------------------------------------------"
                         puts "#{@players[x].name}, we'll start with your original hand."
                         hit_loop(@players[x], @players[x].hand, num_players, ai)
                         puts "-----------------------------------------------------"
                         puts "#{@players[x].name}, now we'll play with your split_hand."
                         hit_loop(@players[x], @players[x].split_hand, num_players, ai)
                     when 3
                         hit_loop(@players[x], @players[x].hand, num_players, ai)
                     end
                end
                player_done = true
            end # player turns
            if ai
                if !comp_done
                    hand_state = check_split_double_down(num_players, ai)
                    case hand_state
                    when 1
                        puts "-----------------------------------------------------"
                        puts "#{@comp.name}, you receive one card."
                        render(false, num_players, ai)
                    when 2
                        puts "-----------------------------------------------------"
                        puts "#{@comp.name}, we'll start with your original hand."
                        ai_hit_loop(num_players, ai)
                        puts "-----------------------------------------------------"
                        puts "#{@comp.name}, now we'll play with your split_hand."
                        ai_hit_loop(num_players, ai)
                    when 3
                        ai_hit_loop(num_players, ai)
                    end
                end
                comp_done = true
            end

        #dealer turns
            if !dealer_done
                puts "-----------------------------------------------------"
                puts "Everyone is done with their turn.  Here is my other card. I will hit until I reach 17 or more."
                render(true, num_players, ai)
                while @dealer.total < 17
                    @dealer.hand << @shoe.shift
                    render(true, num_players, ai)
                end
                dealer_done = true
            end

        #settle
            num_players.times do |x|
                settle(@players[x], @players[x].total, @players[x].bet)
                if !@players[x].split_hand.empty?
                    settle(@players[x], @players[x].split_total, @players[x].split_bet)
                end
            end
            if ai
                settle(@comp, @comp.total, @comp.bet)
                if !@comp.split_hand.empty?
                    settle(@comp, @comp.split_total, @comp.split_bet)
                end
            end

        #continue
            num_players.times do |x|
                if @players[x].chips >=20
                    puts "-----------------------------------------------------"
                    print "#{@players[x].name}, you have enough chips for another hand.  Would you like to continue playing? Please enter 1 to continue or any other key to quit:  "
                    if gets.chomp != "1"
                        @players.delete(@players[x])
                    else
                        puts "Thanks for playing."
                        @players[x].hand.clear
                        if !@players[x].split_hand.empty?
                            @players[x].split_hand.clear
                        end
                    end
                else
                    puts "-----------------------------------------------------"
                    puts "#{@players[x].name}, you do not have enough chips for another hand.  Thanks for playing."
                    @players.delete(@players[x])
                end
            end
            if @comp.chips < 20
                puts "#{@comp.name} does not have enough chips for another hand."
                ai = false
            else
                @comp.hand.clear
                if !@comp.split_hand.empty?
                    @comp.split_hand.clear
                end
            end
            @dealer.hand.clear
            cut_location = rand(80..100)
            puts cut_location
            if @shoe.length < cut_location
                @shoe = create_shoe
            end
            game_over = @players.empty?
        end #Game loop
    end # play method

    #Other methods
    def create_shoe
        rank_hash = {"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": 11}
        suit_arr = [:H, :D, :C, :S]
        shoe_cards = []
        8.times do
            suit_arr.each do |suit|
                rank_hash.each do |rank, value|
                    shoe_cards << Card.new(rank, suit, value)
                end
            end
        end
        shoe_ready = shoe_cards.shuffle
        return shoe_ready
    end #create_shoe method

    def render(dealer_reveal, num_players, ai)
        puts "*******************************************************************************"
        puts @shoe.length
        if dealer_reveal
            puts "Dealer total:  #{@dealer.total}."
            puts "Dealer cards:  #{dealer_hand}"
        else
            puts "Dealer total showing:  #{dealer_total_showing}."
            puts "Dealer cards:  #{dealer_showing}"
        end
        num_players.times do |x|
            puts "-----------------------------------------------------"
            puts "#{@players[x].name}'s bet: #{@players[x].bet}, chips: #{@players[x].chips},  total: #{@players[x].total}."
            if @players[x].insurance_bet > 0
                puts "#{@players[x].name}'s' insurance bet: #{@players[x].insurance_bet}."
            end
            puts "#{@players[x].name}'s' cards:  #{player_hand(@players[x].hand)}"
            if !@players[x].split_hand.empty?
                puts "#{@players[x].name}'s' split cards:  #{player_hand(@players[x].split_hand)}"
            end
        end
        if ai
            puts "-----------------------------------------------------"
            puts "#{@comp.name}'s bet:  #{@comp.bet}, chips:  #{@comp.chips}, total:  #{@comp.total}."
            puts "#{@comp.name}'s cards:  #{player_hand(@comp.hand)}"
            if !@comp.split_hand.empty?
                puts "#{@comp.name}'s' split cards:  #{player_hand(@comp.split_hand)}"
            end
        end
    end #render method

    def dealer_hand #Helper for render
        dealer_hand_string = ""
        @dealer.hand.each do |x|
            dealer_hand_string += "#{x.name}  "
        end
        return dealer_hand_string
    end

    def dealer_total_showing #Helper for render
        tot = 0
        if !@dealer.hand.nil?
            @dealer.hand.each do |dealer_card|
                if !dealer_card.nil?
                    tot += dealer_card.value
                else
                    tot += 0
                end
            end
            face_down = @dealer.hand[1]
            if !face_down.nil?
                tot -= face_down.value
            else
                tot -= 0
            end
        else
            tot = 0
        end
        return tot
    end #dealer_total_showing method

    def dealer_showing #Helper for render
        if !@dealer.hand[0].nil?
            "#{@dealer.hand[0].name}  ??"
        else
           "-- --"
        end
    end # dealer_showing method

    def player_hand(hand)
        if !hand[0].nil?
            player_hand_string = ""
            hand.each do |x|
                player_hand_string += "#{x.name}  "
            end
            return player_hand_string
        else
            "-- --"
        end
    end  # player_hand method

    def bets(num_players, ai)
        num_players.times do |x|
            loop do
                puts "-----------------------------------------------------"
                print "What would you like to bet:  "
                bet = 1
                if bet > @players[x].chips
                    puts "You do not have enough chips to bet that much!"
                else
                    @players[x].bet = bet
                    @players[x].chips -= @players[x].bet
                    puts "#{@players[x].name}'s bet is #{@players[x].bet} chips."
                    break
                end
            end
        end
        if ai
            loop do
                if @comp.chips > 40
                    @comp.bet = 40
                    @comp.chips -= @comp.bet
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name}'s bet is #{@comp.bet} chips."
                    break
                else
                    @comp.bet = 20
                    @comp.chips -= @comp.bet
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name}'s bet is #{@comp.bet} chips."
                    break
                end
            end
        end
    end #bets method

    def deal(num_players, ai)
        2.times do
            @dealer.hand << @shoe.shift
            num_players.times do |x|
                @players[x].hand << @shoe.shift
            end
            if ai
                @comp.hand << @shoe.shift
            end
        end
    end # deal method

    def insurance(num_players, ai)
        num_players.times do |x|
            puts "-----------------------------------------------------"
            print "#{@players[x].name}, please enter 1 if you would like to make an insurance sidebet or any other key if you would not:  "
            if gets.chomp.to_i == 1
                puts "-----------------------------------------------------"
                print "You may bet up to #{(@players[x].bet / 2).floor} which is half of your original bet (rounded down if needed).  How much would you like your insurance side bet to be:  "
                @players[x].insurance_bet = gets.chomp.to_i
            end
            render(false, num_players, ai)
        end
    end  # insurance method

    def dealer_naturals(num_players, ai)
        if @dealer.blackjack(@dealer)
            render(true, num_players, ai)
            num_players.times do |x|
                if @players[x].insurance_bet > 0
                    puts "-----------------------------------------------------"
                    puts "#{@players[x].name}, your insurance_bet winngs are $#{@players[x].insurance_bet * 2}."
                    @players[x].chips += (@players[x].insurance_bet * 2)
                    @players[x].insurance_bet = 0
                end
                if @players[x].blackjack(@players[x])
                    puts "-----------------------------------------------------"
                    puts "#{@players[x].name}, we drew with natural blackjacks. Your bet will be returned"
                    @players[x].chips += @players[x].bet
                    @players[x].bet = 0
                end
                if @players[x].total < 21
                    puts "-----------------------------------------------------"
                    puts "#{@players[x].name}, you lost this hand and your bet."
                    @players[x].bet = 0
                end
                render(true, num_players, ai)
            end
            if ai
                if @comp.blackjack(@comp)
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name}, we drew with natural blackjacks. Your bet will be returned"
                    @comp.chips += @comp.bet
                    @comp.bet = 0
                end
                if @comp.total < 21
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name}, you lost this hand and your bet."
                    @comp.bet = 0
                end
                render(true, num_players, ai)
            end
        end
    end

    def check_split_double_down(num_players, ai)
        num_players.times do |x|
            if (@players[x].chips >= @players[x].bet) &&                (@players[x].hand[0].rank == @players[x].hand[1].rank) &&
                (@players[x].total == 10)
                puts "-----------------------------------------------------"
                print "#{@players[x].name}, you enough chips and the right cards to either double down or split. Please enter 1 to Double Down, 2 to Split, or any other key to play current hand:  "
                if gets.chomp = "1"
                    double_down(@players[x])
                    return  1
                elsif gets.chomp = "2"
                    split(@players[x])
                    return 2
                else
                    return 3
                end
            elsif (@players[x].chips >= @players[x].bet) &&                (@players[x].hand[0].rank == @players[x].hand[1].rank)
                puts "-----------------------------------------------------"
                print "#{@players[x].name}, you have enough chips and the right cards to split. Please enter 1 to split or any other key to play current hand:  "
                if gets.chomp == "1"
                    split(@players[x])
                    return 2
                end
            elsif (@players[x].chips >= @players[x].bet) &&            ((@players[x].total == 9) || (@players[x].total == 10) || (@players[x].total == 11))
                print "#{@players[x].name}, you have enough chips and the right cards to double down.  Please enter 1 to double down or any other key to play current hand  "
                if gets.chomp == "1"
                    double_down(@players[x])
                    return 1
                end
            else
                return 3
            end
        end
        if ai
            dealer_9_set = [7, 10, 11]
            dealer_good = [8, 9, 10, 11]
            dealer_bad = [2, 3, 4, 5, 6]
            if (@comp.chips >= @comp.bet) &&  (@comp.hand[0].rank == @comp.hand[1].rank) && (@comp.total == 10)
                puts "-----------------------------------------------------"
                puts "#{@comp.name} will double down."
                double_down(@comp)
                return 1
            elsif (@comp.chips >= @comp.bet) &&                (@comp.hand[0].rank == @comp.hand[1].rank)
                card = @comp.hand[0].value
                if ((card == 2) &&      (!dealer_good.include(dealer_total_showing)))  ||
                    ((card == 3) && (!dealer_good.include(dealer_total_showing))) ||
                    ((card == 7) && (!dealer_good.include(dealer_total_showing))) ||
                    ((card == 6) && (dealer_bad.include(dealer_total_showing))) ||
                    ((card == 9) && (!dealer_9_set.include(dealer_total_showing))) ||
                    (card == 8) || (card == 11)
                    puts "-----------------------------------------------------"
                    puts "#{@comp.name} will split."
                    split(@comp)
                    return 2
                end
            elsif  (@comp.chips >= @comp.bet) &&  (((@comp.total == 9) && (dealer_bad.include(dealer_total_showing)) ) || (@comp.total == 10) && (!dealer_9_set.include(dealer_total_showing) || (@comp.total == 11)))
                puts "-----------------------------------------------------"
                puts "#{@comp.name} will double down."
                double_down(@comp)
                returns 1
            else
                puts "-----------------------------------------------------"
                puts "#{@comp.name} will play current hand."
                return 3
            end
        end
    end # check_split_double_down method

    def double_down(player)
        player.chips -= player.bet
        player.bet += player.bet * 2
        player.hand << @shoe.shift
    end # double_down method

    def split(player)
        player.split_hand = []
        player.split_hand << player.hand.pop
        player.hand << @shoe.shift
        player.split_hand << @shoe.shift
        player.chips -= player.bet
        player.split_bet += player.bet
    end #split method

    def hit_loop(player, player_hand, num_players, ai)
        stand = false
        while !stand do
            puts "-----------------------------------------------------"
            puts "#{player.name}, would you like another card?  Please enter 1 to Hit or any other key to Stand:  "
            if gets.chomp == "1"
                player_hand << @shoe.shift
                render(false, num_players, ai)
                if player.bust(player)
                    stand = true
                end
            else
                stand = true
            end
        end
    end

    def ai_hit_loop(num_players, ai)
        @comp.hand.each do |card|
            if  card.value == 11
                while @comp.total <= 18 do
                    @comp.hand << @shoe.shift
                    render(false, num_players, ai)
                end
            elsif ((dealer_total_showing >= 7 ) && (dealer_total_showing <= 11))
                while @comp.total <=17 do
                    @comp.hand << @shoe.shift
                    render(false, num_players, ai)
                end
            elsif ((dealer_total_showing >=4) && (dealer_total_showing <= 6))
                while @comp.total <= 12 do
                    @comp.hand << @shoe.shift
                    render(false, num_players, ai)
                end
            else
                while @comp.total <= 13 do
                    @comp.hand << @shoe.shift
                    render(false, num_players, ai)
                end
            end
        end
    end

    def settle(player, total, bet)
        win = false
        if player.bust(player)
            win = false
        elsif total > @dealer.total
            win = true
        elsif total < @dealer.total
            win = false
        end
        if win == true
            player.chips += bet * 2
            player.bet = 0
            puts "-----------------------------------------------------"
            puts "#{player.name}, you won this hand and your bet."
        elsif win == false
            player.bet = 0
            puts "#{player.name}, you lost this hand and your bet."
        else
            player.chips += bet
            player.bet = 0
            puts "#{player.name}, your chips are being returned."
        end
    end

end# Game class


g = Game.new
g.play
