class StringCalculator
    def add(numbers)
        return 0 if numbers.empty?

        numbers.gsub("\n", ",").split(",").map(&:to_i).sum
    end
end