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
    
    def my_rotate(n = 1) 
        
        # Returns a new array containing all the elements of the original array in a rotated order.
        # By default, the array should rotate by one element.
        # If a negative value is given, the array is rotated in the opposite direction.

        rotated = []
        self.length.times do |i|
            old_position = (i + n) % self.length
            rotated[i] = self[old_position]
        end
        rotated

    end
    
    def my_join(separator = '')
        
        # Returns a single string containing all the elements of the array,
        # separated by the given string separator.
        # If no separator is given, an empty string is used.

        puts 'method called'
        new_string = ''
        self.length.times do |i| 
            new_string += self[i]
            new_string += separator unless i == self.length - 1
        end
        new_string
    
    end

    def my_reverse

        # Returns a new array containing all the elements of the original array in reverse order.

        reversed = []
        self.length.times do |i| 
            old_position = self.length - i - 1
            reversed << self[old_position]
        end
        reversed
        
    end


end