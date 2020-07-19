require_relative 'app/dealer'
require_relative 'app/player'
require_relative 'app/deck'
require_relative 'app/hand'

module TwentyOne
  class Game
    def initialize
      @dealer = Dealer.new
      @player = Player.new
      @deck = Deck.new
    end

    def start
      loop do
        play_hand
        display_result
        play_again? ? reset : break
      end
      puts 'Thank you for playing!'
    end

    private

    def play_hand
      loop do
        deal_starting_hand
        break if @player.blackjack? || @dealer.blackjack?
        player_turn
        break if @player.bust?
        dealer_turn
        break
      end
    end

    def display_result
      @dealer.reveal_hand
      display_hands

      if @player.blackjack? || @dealer.blackjack?
        puts display_blackjack
      elsif @player.bust? || @dealer.bust?
        puts display_bust
      else
        puts display_winner
      end
    end

    def display_blackjack
      if @player.blackjack? && @dealer.blackjack?
        'Both player and dealer have twenty-one, push.'
      elsif @player.blackjack?
        'Winner winner chicken dinner. Player has twenty-one!'
      else
        "Dealer has blackjack, dealer wins."
      end
    end

    def display_bust
      if @player.bust?
        "Player busts. Dealer wins."
      else
        "Dealer busts. Player wins."
      end
    end

    def display_winner
      if @player.hand == @dealer.hand
        "Push."
      elsif @player.hand > @dealer.hand
        "Player wins."
      else
        "Dealer wins."
      end
    end

    def reset
      @player.new_hand
      @dealer.new_hand
    end

    def play_again?
      answer = nil
      puts "--"
      puts "Would you like to play again? (y/n)"
      loop do
        answer = gets.chomp.downcase
        break if ['y', 'n', 'yes', 'no'].include?(answer)
        puts "Invalid response, please try again."
      end
      ['y', 'yes'].include?(answer) ? true : false
    end

    def deal_starting_hand
      @player.hand << @deck.deal
      @dealer.hand << @deck.deal.hide
      @player.hand << @deck.deal
      @dealer.hand << @deck.deal
      display_hands
    end

    def display_hands
      system 'clear'
      puts "TWENTY-ONE"
      puts "by Connor Maher"
      puts ""
      @player.display_hand
      @dealer.display_hand
    end

    def player_turn
      loop do
        break unless @player.hit?
        @player.hand << @deck.deal
        display_hands
      end
    end

    def dealer_turn
      @dealer.reveal_hand
      loop do
        break unless @dealer.hit?
        @dealer.hand << @deck.deal
        display_hands
      end
    end
  end
end

TwentyOne::Game.new.start
