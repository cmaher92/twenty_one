require_relative 'participant'
require_relative 'hand'

module TwentyOne
  # represents a Dealer
  class Dealer < Participant
    def initialize
      super
    end

    def hit?
      @hand.value < 17
    end

    def reveal_hand
      @hand.reveal
    end

    def display_hand
      puts ''
      puts "Dealer's Hand"
      puts @hand
      puts ''
    end

    def to_s
      'Dealer'
    end
  end
end
