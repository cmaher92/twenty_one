require_relative 'hand'
require_relative 'card'

module TwentyOne
  # parent class for Player and Dealer
  class Participant
    attr_accessor :hand

    def initialize
      @hand = Hand.new
    end

    def add_to_hand(card, hidden = false)
      return @hand << card.hide if hidden
      @hand << card
    end

    def==(other)
      @hand == other.hand
    end

    def >(other)
      @hand > other.hand
    end

    def bust?
      @hand.value > 21
    end

    def max?
      @hand.value == 21
    end

    def blackjack?
      @hand.blackjack?
    end

    def new_hand
      @hand = Hand.new
    end
  end
end
