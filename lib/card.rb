class Card
  attr_accessor :suit, :value, :card

  def initialize (suit, value)
    @suit = suit
    @value = value
    @card = [suit, value]
  end

  def display_rank
    case @value
    when 11
      return "J"
    when 12
      return "Q"
    when 13
      return "K"
    when 14
      return "A"
    else
      return @value
    end
  end

  def display_value
    case @value
    when (10..13)
      return 10
    when  14
      return 11
    else
      return @value
    end
  end
end
