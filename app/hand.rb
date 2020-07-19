require_relative 'card'
require 'pry'

module TwentyOne
  class Hand
    EMPTY = '     '
    HIT = [EMPTY, EMPTY, EMPTY, 'HIT'.center(5), EMPTY, EMPTY, EMPTY]
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

    def >(other_hand)
      @value > other_hand.value
    end

    def ==(other_hand)
      @value == other_hand.value
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
      [' ', ' ', ' ', "TOTAL:".center(8), value.to_s.center(8), ' ', ' ']
    end

    def hand_details
      # takes cards, hits, and hand value and combines to display
      # on a single row
      # [] [] HIT [] TOTAL
      cards_hits_and_total = retrieve_cards_hits_and_total

      hand_details = []
      7.times do |row_idx|
        row = []
        cards_hits_and_total.each { |card| row << card[row_idx] }
        hand_details << row.join('')
      end
      hand_details
    end

    def retrieve_cards_hits_and_total
      # adds text to indicate when participant hits and value of hand
      cards = @hand.map(&:displayable)
      add_hits(cards) << displayable_value
    end

    def add_hits(cards)
      cards_and_hits = []
      cards.each_with_index do |card, idx|
        cards_and_hits << HIT if idx > 1
        cards_and_hits << card
      end
      cards_and_hits
    end
  end
end
