require 'ruby-poker'

class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def find_best
    card_array = cards.split(' ')
    permutations = card_array.permutation(5).to_a
    best = PokerHand.new(card_array[0..4])

    permutations.each do |permutation|
      current_hand = PokerHand.new(permutation)
      best = best > current_hand ? best : current_hand
    end
    best.to_s
  end
end

describe Hand do
  describe '#find_best' do
    context 'when you have less than 5 cards' do
      it 'returns your entire hand' do
        hand = Hand.new('9h 9c')
        expect(hand.find_best).to eq '9h 9c (Pair)'
      end
    end

    context "when you have exactly 5 cards" do
      it 'returns your entire hand' do
        hand = Hand.new("8H 9C TC JD QH")
        expect(hand.find_best).to eq "8h 9c Tc Jd Qh (Straight)"
      end
    end

    context "when you have more than 5 cards" do
      it 'returns the 5 cards in the best hand' do
        hand = Hand.new('8H 9C 2C TC JD QH')
        expect(hand.find_best).to eq "8h 9c Tc Jd Qh (Straight)"
      end
    end
  end

end
