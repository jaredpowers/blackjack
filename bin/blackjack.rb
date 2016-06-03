require_relative "../lib/card.rb"
require_relative "../lib/deck.rb"

class Player (name)
  def initialize
    @name = name
  end
end

def play_blackjack
  puts "Welcome to Blackjack!!"
  sleep 1
  puts "Type (p) to play or (q) to quit"
  choice = gets.chomp.downcase
  if choice == "p"
    puts "Let's play"
    @bust = "no"
    @computer_busted = "no"
  elsif choice == "q"
    puts "See you soon"
    exit
  else
    puts "That was neither play or quit."
    play_blackjack
  end
end

def display_hand(hand)
  hand.each do |card|
    print "#{card.display_rank} of #{card.suit} "
  end
end

def show_dealer_hand(hand)
  print "Dealer hand is... "
  print "#{hand.first.display_rank} of #{hand.first.suit} \n"
end

def hand_value(hand)
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  return amount
end

def hit_or_stand (hand, deck)
  puts "Hit or stand?"
  answer = gets.chomp.downcase
  if answer == "hit"
    @card = hand.push(deck.draw)
  elsif answer == "stand"
    @go_again = "no"
  else
    puts "Please select hit or stand."
    hit_or_stand(hand, deck)
  end
end

def check_blackjack(hand, string)
  @player_black_jack = "no"
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  if amount == 21 || amount == 22
    puts "Blackjack!"
    @go_again = "no"
    puts "#{string} has a Blackjack!"
    if string == "Player"
      @player_black_jack = "yes"
    elsif string == "Computer"
      @computer_black_jack = "yes"
    end
  end
end

def bust(hand)
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  if amount < 22
    @bust = "no"
  else
    @bust = "yes"
  end
end

def dealer_logic(hand, deck)
  if @player_black_jack == "yes"
    @dealer_score = 0
  elsif @computer_black_jack == "yes"
    puts "Dealer Wins!"
    print "-" * 20
    print "\n"
  else
    print "*" * 20
    puts
    print "Dealer's turn!"
    puts
    print "*" * 20
    puts
    print "Dealer: "
    display_hand(hand)
    check_blackjack(hand, "Computer")
    print "-" * 20
    print "\n"
    amount = hand_value(hand)
    print "Dealer hand:"
    display_hand(hand)
    print "-" * 20
    print "\n"
    while amount < 16
      @card = hand.push(deck.draw)
      puts "Dealer hits!"
      print "-" * 20
      print "\n"
      display_hand(hand)
      print "-" * 20
      print "\n"
      amount = hand_value(hand)
    end
    puts "Dealer stands."
    @dealer_score = amount
    if amount < 22
      puts "Dealer has #{amount}"
      @dealer_score = amount
    elsif amount >= 22
      puts "Dealer has #{amount}."
      puts "Dealer busts!"
      @dealer_score = amount
      @computer_busted = "yes"
    else
      puts "Something went wrong."
    end
  end
end

def determine_winner(c_score, score)
  if @player_black_jack == "yes"
    puts "You win!"
  elsif @computer_black_jack == "yes"
    puts "The Computer won..."
  elsif @bust == "yes" && @computer_busted == "yes"
    puts "Even Split"
  elsif @bust == "yes"
    puts "Computer wins!"
  elsif @computer_busted == "yes"
    puts "You win!"
  elsif score > c_score
    puts "You win!"
  elsif c_score > score
    puts "The Computer won..."
  elsif score == c_score
    puts "The game is a draw."
  else
    puts "Something went wrong."
  end
  print "-" * 20
  print "\n"
  sleep 1.5
end

def deal_cards(hand, deck)
  @card = hand.push(deck.draw)
  @card_two = hand.push(deck.draw)
end

class PlayBlackjack
    loop do
      play_blackjack
      deck = Deck.new
      deck.shuffle
      hand = []
      dealer_hand = []
      @go_again = "yes"
      @bust = "no"
      deal_cards(hand, deck)
      deal_cards(dealer_hand, deck)
      show_dealer_hand(dealer_hand)
      print "Players hand: "
      display_hand(hand)
      print "-" * 20
      print "\n"
      check_blackjack(hand, "Player")
      puts "Player has: #{hand_value(hand)}"
      while @bust == "no" && @go_again == "yes"
        @player_score = hand_value(hand)
        hit_or_stand(hand, deck)
        print "-" * 20
        print "\n"
        @player_score = hand_value(hand)
        print "Players hand: "
        display_hand(hand)
        print "-" * 20
        print "\n"
        puts "Player has: #{hand_value(hand)}"
        print "-" * 20
        print "\n"
        bust(hand)
    end
    dealer_logic(dealer_hand, deck)
    determine_winner(@dealer_score, @player_score)
  end
end
