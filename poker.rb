require_relative 'hand'
require_relative 'card'

class Poker
  RANK = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_reader :hands

  def initialize(hand_arrays)
    @hands = hand_arrays.map { |hand_array| Hand.new(hand_array) }
  end

  def best_hand
    [
      (
        highest_straight_hand ||
        highest_three_of_a_kind_hand ||
        highest_two_pair_hand ||
        heighest_pair_hand ||
        heighest_ranked_hand
      ).card_strings
    ]
  end

  private

  def highest_straight_hand
  end

  def highest_three_of_a_kind_hand
    hands.select(&:three).max_by { |hand| pair_score(hand.three) }
  end

  def highest_two_pair_hand
    hands.select { |hand| hand.pairs.size == 2 }.max_by { |hand|
      pairs_score(hand.pairs)
    }
  end

  def heighest_pair_hand
    hands.select{ |hand| hand.pairs.size == 1 }.max_by { |hand|
      pairs_score(hand.pairs)
    }
  end

  def heighest_ranked_hand
    hands.max_by { |hand| RANK.index(hand.highest_rank) }
  end

  def pairs_score(pairs)
    pairs.map { |pair| pair_score(pair) }.sort.reverse.join(".").to_f
  end

  def pair_score(pair)
    RANK.index(pair.first.rank)
  end
end

