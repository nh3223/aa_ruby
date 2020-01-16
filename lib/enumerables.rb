class Array

    def my_each(&prc)

        # Takes a block as an argument, calls the block on every element of the array, and returns the original array. 
        self.length.times do |i|
            prc.call(self[i])
        end

        self

    end

    def my_select(&prc)

        # Takes a block as an argument and returns a new array containing only elements that satisfy the block.        
        # Use your my_each method!
        
        selected = []
        self.my_each { |e| selected << e if prc.call(e) }
        selected
    
    end
    
    def my_reject(&prc)

        # Take a block as an argument and return a new array excluding elements that satisfy the block.

        rejected = []
        self.my_each { |e| rejected << e unless prc.call(e) }
        rejected
    
    end

end