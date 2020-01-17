require_relative "Player"
require_relative "Game"

def welcome
    puts 'Welcome to Ghost!'
    puts 'Players take turns adding a letter to a word fragment, but try not to make words.'
    puts 'If you make a word, you get a letter.  Once you spell Ghost, you are out!'    
end
    
def get_players
    puts 'How many players are there?'
    players = []
    number_of_players = gets.chomp.to_i
    (1..number_of_players).each { |num| players << create_player(num) }
    puts 'Do you want to play with the computer (y/n)?'
    players << AIPlayer.new if gets.chomp.downcase == 'y'
    players
end

def create_player(num)
    puts "Player #{num}, what is your name?"
    player = Player.new(gets.chomp)
end

def play_game(players)
    game = Game.new(players)
    winner = game.play_round
    puts "Game over!  Congratulations, #{winner.name}, you won!"
end

def play_again?
    puts 'Do you want to play again (y/n)?'
    return true if gets.chomp.downcase == 'y'
    false
end

welcome
play = true
while play
    players = get_players
    play_game(players)
    play = play_again?
end
puts 'Goodbye!'




