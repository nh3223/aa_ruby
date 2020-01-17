require_relative "Game"

class AIPlayer

    attr_reader :alphabet, :name
    
    def initialize
        @name = 'HAL'
        @alphabet = 'abcdefghijklmnopqrstuvwxyz'
    end

    def guess(fragment, players, dictionary)
        return fragment_empty? if fragment == ''
        losing_letters = check_next_letter(fragment, dictionary)
        check_subsequent_letters(losing_letters, dictionary, fragment, players).sample
    end

    def fragment_empty?
        alphabet.split('').sample
    end

    def check_next_letter(fragment, dictionary)
        words_formed = []
        alphabet.each_char { |c| words_formed << c if dictionary[fragment[0]].include?(fragment + c) }
        words_formed
    end

    def check_subsequent_letters(losing_letters, dictionary, fragment, players)
        available_letters = []
        alphabet.each_char { |c| available_letters << c if !losing_letters.include?(c) }
        remaining_words = create_sub_dictionary(available_letters, dictionary, fragment)
        potential_winning_letters = []
        available_letters.each { |c| potential_winning_letters << c if !remaining_words[c].empty? }
        winning_letters = []
        potential_winning_letters.each do |c|
            winning_letters << c if remaining_words[c].all? { |word| word.length < fragment.length + players.length + 1 }
        end
        if potential_winning_letters.empty?
            words_formed = []
            alphabet.each_char { |c| words_formed << c if dictionary[fragment[0]].include?(fragment + c) }
            return words_formed.sample(1)
        elsif winning_letters.empty?
            return potential_winning_letters.sample(1)
        else
            return winning_letters.sample(1)  
        end
    end

    def create_sub_dictionary(available_letters, dictionary, fragment)
        sub_dictionary = Hash.new() { |h, k| h[k] = [] }
        available_letters.each do |c|
            new_fragment = fragment + c
            dictionary[fragment[0]].each do |word| 
                if word[0..fragment.length] == new_fragment
                    sub_dictionary[c] << word 
                end
            end
        end
        sub_dictionary
    end

end
