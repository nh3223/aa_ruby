require_relative "Player"

class Game

    attr_accessor :fragment, :current_player, :losses, :players
    attr_reader :dictionary

    def initialize(players)
        @players = players
        @current_player = players[0]
        @fragment = ''
        @dictionary = load_dictionary
        @losses = Hash.new { |losses, player| losses[player] = 0 }
    end

    def load_dictionary
        dictionary = Hash.new { |h, k| h[k] = [] }
        File.readlines('dictionary.txt').each { |line| dictionary[line[0]] << line.chomp }
        dictionary
    end

    def play_round
        while players.length > 1
            self.fragment = ''
            while take_turn(current_player)
                next_player
            end
            update_losses
            if losses[current_player] == 5 then player_out else next_player end 
            display_standings
        end
        players[0]
    end

    def update_losses
        losses[current_player] += 1
    end
    
    def player_out
        loser = current_player
        puts "Sorry, #{loser.name}, you are out."
        next_player
        players.delete(loser)
    end

    def display_standings
        puts 'Current Standings'
        players.each { |player| puts "#{player.name}: #{record(player)}" }
    end

    def record(player)
        status = 'GHOST'
        status[0...losses[player]]
    end


    def take_turn(player)    
        if fragment == ''
            puts "#{player.name}, you start."
        else
            puts "#{player.name}, it's your turn.\nThe current fragment is #{fragment}"
        end
        s = get_player_guess(player)
        update_fragment(s)
        check_dictionary
    end

    def get_player_guess(player)        
        p player
        while true
            s = player.guess if player.is_a?(Player)
            s = player.guess(fragment, players, dictionary) if player.is_a?(AIPlayer)
            if valid_play?(s)
                return s
            end
            player.alert_invalid_guess if player.is_a?(Player)
        end
    end
        
    def update_fragment(s)
        fragment << s
    end

    def check_dictionary
        if dictionary[fragment[0]].include?(fragment)
            puts "#{current_player.name}, you spelled #{fragment}.  You lose this round."
            return false
        end
        true
    end


    def valid_play?(guess)
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        return false unless alphabet.include?(guess) and guess.length == 1
        return !dictionary[guess].empty? if fragment == ''
        dictionary[fragment[0]].any? { |word| word.start_with?(fragment + guess) }
    end
        
    def next_player     
        self.current_player = players[(players.index(current_player) + 1) % players.length]
    end

end

    
        