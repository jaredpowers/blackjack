require_relative '../lib/deck.rb'
require_relative '../lib/card.rb'

class Blackjack
  def start
    puts "Hello! Let's play some blackjack"
    puts "-" * 20
    dec = Deck.new

  end
end

Blackjack.new.start
