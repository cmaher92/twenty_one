require_relative 'card'

module TwentyOne
  # reprents a hand belonging to either Player or Dealer
  class Hand
    EMPTY = '     '.freeze
    attr_reader :hand, :value

    def initialize
      @hand = []
      @value = 0
      @busted = false
    end

    def busted?
      @busted
    end

    def blackjack?
      @hand.first(2).map(&:value).sum == 21
    end

    def reveal
      @hand.each(&:reveal)
    end

    def <<(card)
      @hand << card
      @value += card.value
      calc_value_for_ace if ace?
      @busted = true if @value > 21
    end

    def >(other)
      @value > other.value
    end

    def ==(other)
      @value == other.value
    end

    def to_s
      hand_details.join("\n")
    end

    private

    def ace?
      @hand.any?(&:ace?)
    end

    def calc_value_for_ace
      return if @value < 22
      @hand.select(&:ace?).first.value = 1 # set aces value to 1
      @value -= 10
    end

    def displayable_value
      value = @hand.reject(&:hidden?).map(&:value).sum
      [' ', ' ', ' ', 'TOTAL:'.center(8), value.to_s.center(8), ' ', ' ']
    end

    def hand_details
      # takes cards, hits, and hand value and combines to display
      # on a single row
      # [] [] HIT [] TOTAL
      cards_hits_and_total = retrieve_cards_hits_and_total

      hand_details = Array.new(7) { [] }
      cards_hits_and_total.each do |card|
        card.each_with_index do |row, idx|
          hand_details[idx] << row
        end
      end

      hand_details.map(&:join)
    end

    def retrieve_cards_hits_and_total
      # add hand total value
      cards = @hand.map(&:displayable)
      add_hits(cards) << displayable_value
    end

    def add_hits(cards)
      # adds text to indicate when participant hits and value of hand
      hit = [EMPTY, EMPTY, EMPTY, 'HIT'.center(5), EMPTY, EMPTY, EMPTY]
      cards_and_hits = []
      cards.each_with_index do |card, idx|
        cards_and_hits << hit if idx > 1
        cards_and_hits << card
      end
      cards_and_hits
    end
  end
end
