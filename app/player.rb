require_relative 'participant'
require_relative 'hand'

module TwentyOne
  class Player < Participant
    def initialize
      super
    end

    def hit?
      return false if max? || bust?
      response = nil
      loop do
        puts "--"
        puts "Would you like to hit or stay? (h/s)"
        response = gets.chomp.downcase
        break if %w(h hit s stay).include?(response)
        puts "'#{response}' is an invalid response, please try again."
      end
      %w(h hit).include?(response)
    end

    def display_hand
      puts "Your hand"
      puts @hand
      puts ""
    end
  end
end
