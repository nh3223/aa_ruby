require_relative "Game"

class AIPlayer

    attr_reader :alphabet, :name
    
    def initialize

        @name = 'HAL'
        @alphabet = 'abcdefghijklmnopqrstuvwxyz'
    
    end

    def guess(fragment, players, dictionary)
     
        return self.fragment_empty? if fragment == ''
        losing_letters = self.check_next_letter(fragment, dictionary)
        self.check_subsequent_letters(losing_letters, dictionary, fragment, players).sample

    end

    def fragment_empty?

        self.alphabet.split('').sample
        
    end

    def check_next_letter(fragment, dictionary)

        words_formed = []
        self.alphabet.each_char { |c| words_formed << c if dictionary[fragment[0]].include?(fragment + c) }
        words_formed
    
    end

    def check_subsequent_letters(losing_letters, dictionary, fragment, players)

        available_letters = []
        self.alphabet.each_char { |c| available_letters << c if !losing_letters.include?(c) }
        remaining_words = self.create_sub_dictionary(available_letters, dictionary, fragment)
        potential_winning_letters = []
        available_letters.each { |c| potential_winning_letters << c if !remaining_words[c].empty? }
        winning_letters = []
        potential_winning_letters.each do |c|
            winning_letters << c if remaining_words[c].all? { |word| word.length < fragment.length + players.length + 1 }
        end
        if potential_winning_letters.empty?
            words_formed = []
            self.alphabet.each_char { |c| words_formed << c if dictionary[fragment[0]].include?(fragment + c) }
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



        #Phase Bonus

#     Write an AiPlayer class for your Ghost game. 
#You'll need to figure out the logic for picking a winning letter on each turn. 
#In order to do this, your AiPlayer will need to know both the current fragment
# and the number of other players (n).
#         If adding a letter to the fragment would spell a word, then the letter is a losing move.
#         If adding a letter to the fragment would leave only words with
# n or fewer additional letters as possibilities, then the letter is a winning move.
#         Your AI should take any available winning move; if none is available, randomly select a losing move.
#             See if you can improve your AI by computing the entire tree of possible moves 
#from the current position. 
#Choose the move that leaves the fewest losers and the most winners in the tree.