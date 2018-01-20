require_relative 'poker'

class Hand
  attr_reader :cards, :card_strings
  def initialize(card_strings)
    @card_strings = card_strings
    @cards = card_strings.map { |card_string| Card.new(card_string) }
  end

  def highest_rank
    @cards.max_by { |card| Poker::RANK.index(card.rank) }.rank
  end

  def pairs
    cards.group_by(&:rank).map { |_, group| group }
      .select { |group| group.size == 2 }
  end

  def three
    cards.group_by(&:rank).map { |_, group| group }
      .detect { |group| group.size == 3 }
  end

  def straight
    cards.sort_by(&:rank)
  end
end
