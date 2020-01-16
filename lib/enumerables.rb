class Array

    def my_each(&prc)

        # Takes a block as an argument, calls the block on every element of the array, and returns the original array. 
        self.length.times do |i|
            prc.call(self[i])
        end

        self

    end

end