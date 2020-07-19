module TwentyOne
  class Card
    EMPTY_CARD = ['┌', '│', '│', '│', '│', '│', '└']
    attr_accessor :value

    def initialize(face, suit)
      @face = face
      @suit = suit
      @value = calc_value
    end

    def ace?
      @value == 11
    end

    def hide
      @hidden = true
      self
    end

    def reveal
      @hidden = false
      self
    end

    def hidden?
      !!@hidden
    end

    def displayable
      return card unless hidden?
      EMPTY_CARD
    end

    def card
      [
        ["┌────────┐"],
        ["│#{@face.ljust(2)}      │"],
        ["│        │"],
        ["│   #{emojify_suit}    │"],
        ["│        │"],
        ["│      #{@face.rjust(2)}│"],
        ["└────────┘"]
      ]
    end

    private

    def calc_value
      return 11 if @face == 'A'
      return 10 if %w(J Q K).include?(@face)
      @face.to_i
    end

    def emojify_suit
      case @suit
      when 'Hearts' then "\u{2665}"
      when 'Spades' then "\u{2660}"
      when 'Diamonds' then "\u{2666}"
      when 'Clubs' then "\u{2663}"
      end
    end
  end
end
