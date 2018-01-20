require_relative 'poker'

class Card
  attr_reader :rank, :card_string

  def initialize(card_string)
    @card_string = card_string
    @rank = card_string[0..-2]
  end

  def ==(other)
    @card_string == other.card_string
  end
end
