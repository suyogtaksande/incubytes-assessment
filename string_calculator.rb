class StringCalculator
    def add(numbers)
        return 0 if numbers.empty?

        numbers = extract_delimiter_and_numbers(numbers)
        check_for_negative_numbers(numbers)
        numbers.gsub("\n", ",").split(",").map(&:to_i).sum
    end

    private

    def extract_delimiter_and_numbers(input)
        if input.start_with?("//")
          parts = input.split("\n", 2)
          numbers = parts[1].gsub(parse_delimiter(parts[0]), ",")
        else
          numbers = input
        end
        numbers
    end
    
    def parse_delimiter(delimiter_string)
        delimiter_string.gsub("//", "").strip
    end

    def check_for_negative_numbers(numbers)
        nums = numbers.split(",")
        negatives = nums.select { |num| num.to_i.negative? }
        if negatives.any?
          raise ArgumentError, "negative numbers not allowed #{negatives.join(', ')}"
        end
    end
end