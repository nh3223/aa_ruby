def factors(num)
    factor_list = []
    (1..num).each { |factor| factor_list << factor if num % factor == 0 }
    factor_list
end

class Array
    def bubble_sort!(&prc)
        prc ||= Proc.new { |a, b| a <=> b }
        swap = true
        while swap
            swap = false
            (1...self.length).each do |i|
                if prc.call(self[i-1], self[i]) == 1
                    swap = true
                    self[i-1], self[i] = self[i], self[i-1]
                end
            end
        end
        self
    end

  def bubble_sort(&prc)
      sorted = self.dup
      sorted.bubble_sort!
  end

end

def substrings(string)
    arr = []
    (1..string.length).each do |l|
        (0..string.length - l).each { |i| arr << string[i..i + l - 1] }
    end
    arr
end

def subwords(word, dictionary)
    initial_result = substrings(word)
    initial_result.select { |e| dictionary.include?(e) }
end


