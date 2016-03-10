class Deck
  attr_reader :suits
  def initialize
    suits = [:hearts, :diamonds, :spades, :clubs]
    @suits.each do |suit|
      (2..14).each do |value|
        @cards << Card.new(suite, value)
      end
    end
  end
  end
