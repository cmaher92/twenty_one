require_relative 'card'

module TwentyOne
  class Deck
    attr_reader :deck

    def initialize
      @deck = build_deck.shuffle
    end

    def deal
      if @deck.empty?
        @deck = build_deck.shuffle
      end
      @deck.shift
    end

    private

    def build_deck
      suits = %w(Hearts Diamonds Spades Clubs)
      faces = %w(2 3 4 5 6 7 8 9 10 J Q K A)
      deck = []
      faces.each { |face| suits.each { |suit| deck << Card.new(face, suit) } }
      deck
    end
  end
end
