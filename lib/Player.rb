class Player

    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def guess
        puts "Enter a letter: "
        s = gets.chomp
    end


    def alert_invalid_guess
        puts "That guess was not valid.  Guess again."
    end

end