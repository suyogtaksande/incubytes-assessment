class StringCalculator
    def add(numbers)
        return 0 if numbers.empty?

        numbers = extract_delimiter_and_numbers(numbers)
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
end