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
    
    def my_any?(&prc)

        # Take a block as an argument and return true if any elements of the array satisfies the block.

        self.my_each { |e| return true if prc.call(e) }
        false

    end
    
    def my_all?(&prc)

        # Take a block as an argument and return true only if all elements satisfy the block.

        self.my_each { |e| return false unless prc.call(e) }
        true
    
    end 
    
    def my_flatten
    
        #    Return all elements of the array into a new, one-dimensional array. Hint: use recursion!
        
        flattened = []
        self.my_each { |e| if e.is_a?(Array) then flattened += e.my_flatten else flattened << e end }
        flattened
    
    end

    def my_zip(*args)

        # Takes any number of arguments
        # It should return a new array containing self.length elements.
        # Each element of the new array should be an array with a length of the input arguments + 1
        # and contain the merged elements at that index.
        # If the size of any argument is less than self, nil is returned for that location.
        zipped_array = []
        self.length.times do |i|
            sub_array = [self[i]]
            args.my_each { |arg_e| sub_array << arg_e[i] }
            zipped_array << sub_array
        end
        zipped_array            

    end

end