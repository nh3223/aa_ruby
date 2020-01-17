require_relative "Player"

class Game

    attr_accessor :fragment, :current_player, :losses, :players
    attr_reader :dictionary

    def initialize(players)

        # Assign instance variables for the players, current player, fragment, and dictionary.

        @players = players
        @current_player = players[0]
        @fragment = ''
        @dictionary = self.load_dictionary
        @losses = Hash.new { |losses, player| losses[player] = 0 }

    end

    def load_dictionary
        
        dictionary = Hash.new { |h, k| h[k] = [] }
        File.readlines('dictionary.txt').each { |line| dictionary[line[0]] << line.chomp }
        dictionary

    end

    def play_round
    
        while self.players.length > 1
        
            self.fragment = ''
        
            while self.take_turn(self.current_player)
                self.next_player
            end
        
            self.update_losses
            if self.losses[self.current_player] == 5 then self.player_out else self.next_player end 
            self.display_standings
            
        end

        return self.players[0]

    end

    def update_losses
        
        self.losses[self.current_player] += 1
    
    end
    
    def player_out
    
        loser = self.current_player
        puts "Sorry, #{loser.name}, you are out."
        self.next_player
        self.players.delete(loser)
    
    end

    def display_standings
    
        puts 'Current Standings'
        self.players.each { |player| puts "#{player.name}: #{self.record(player)}" }
    
    end

    def record(player)

        status = 'GHOST'
        status[0...self.losses[player]]

    end


    def take_turn(player)
        
        if self.fragment == ''
            puts "#{player.name}, you start."
        else
            puts "#{player.name}, it's your turn.\nThe current fragment is #{self.fragment}"
        end
        s = self.get_player_guess(player)
        self.update_fragment(s)
        self.check_dictionary
    
    end

    def get_player_guess(player)
        
        while true
            s = player.guess if player.is_a?(Player)
            s = player.guess(self.fragment, self.players, self.dictionary) if player.is_a?(AIPlayer)
            if self.valid_play?(s)
                return s
            end
            player.alert_invalid_guess if player.is_a?(Player)
        end

    end
        
    def update_fragment(s)
        
        fragment << s

    end

    def check_dictionary

        if @dictionary[self.fragment[0]].include?(self.fragment)
            puts "#{self.current_player.name}, you spelled #{self.fragment}.  You lose this round."
            return false
        else
            return true
        end

    end


    def valid_play?(guess)

        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        return false unless alphabet.include?(guess) and guess.length == 1
        return !dictionary[guess].empty? if fragment == ''
        dictionary[fragment[0]].any? { |word| word.start_with?(fragment + guess) }
        
    end
        
    def next_player
        
        current_player = players[(players.index(current_player) + 1) % players.length]
    
    end

end

    
        