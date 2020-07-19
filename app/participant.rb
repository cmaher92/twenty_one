require_relative 'hand'
require_relative 'card'

module TwentyOne
  class Participant
    attr_accessor :hand

    def initialize
      @hand = Hand.new
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
