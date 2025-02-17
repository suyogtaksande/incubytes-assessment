require_relative '../string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  
  describe "#add" do
    it "returns 0 for an empty string" do
      puts "calculator.add: #{calculator.add("")}"
      expect(calculator.add("")).to eq(0)
    end

    it 'should return sum for multiple string integers' do
      string = "1,2,6,10"
      expect(calculator.add(string)).to eq(string.split(",").map(&:to_i).sum)
    end

    it "should allow new line inserted in between and return the sum" do
      string = "1\n2,3\n\n4"
      sum = string.gsub("\n", ",").split(",").map(&:to_i).sum
      expect(calculator.add(string)).to eq(sum)
    end

    it 'should handle delimiters & returns the sum' do
      string = "//;\n1;2"
      expect(calculator.add(string)).to eq(3)
    end

    it "should handle negative numbers in the string" do
      string = "1,2,-3,4,-5"
  
      begin
        calculator.add(string)
      rescue ArgumentError => e
        negatives = string.split(",").select { |num| num.to_i.negative? }
        expected_message = "negative numbers not allowed #{negatives.join(', ')}"
        expect(e.message).to eq(expected_message)
      end
    end

    it 'should raises an error for non-integer values' do
      expect { calculator.add("1,a") }.to raise_error(ArgumentError, "string has non integer value.")
    end
  end

  describe '#is_integer?' do
    it 'should returns true for a valid integer string' do
      expect(calculator.send(:is_integer?, '123')).to be true
      expect(calculator.send(:is_integer?, '0')).to be true
      expect(calculator.send(:is_integer?, '-456')).to be true
    end

    it 'should return false for a string with non-integer characters' do
      expect(calculator.send(:is_integer?, '123a')).to be false
      expect(calculator.send(:is_integer?, 'abc')).to be false
      expect(calculator.send(:is_integer?, '12.34')).to be false
    end

    it 'should return false for an empty string' do
      expect(calculator.send(:is_integer?, '')).to be false
    end

    it 'should return false for a string with only whitespace' do
      expect(calculator.send(:is_integer?, ' ')).to be false
      expect(calculator.send(:is_integer?, "\t")).to be false
      expect(calculator.send(:is_integer?, "\n")).to be false
    end
  end

  describe '#parse_delimiter' do
    it 'returns the correct delimiter for a single character delimiter' do
      expect(calculator.send(:parse_delimiter, '//;')).to eq(';')
    end
  end

  describe '#check_for_integer_string' do
    it 'should not raise an error for a valid integer string' do
      expect { calculator.send(:check_for_integer_string, '1,2,3') }.not_to raise_error
      expect { calculator.send(:check_for_integer_string, '0') }.not_to raise_error
      expect { calculator.send(:check_for_integer_string, '-1,2,-3') }.not_to raise_error
    end

    it 'should raise an error for a string with non-integer values' do
      expect { calculator.send(:check_for_integer_string, '1,2,a') }.to raise_error(ArgumentError, 'string has non integer value.')
      expect { calculator.send(:check_for_integer_string, '1.1,2,3') }.to raise_error(ArgumentError, 'string has non integer value.')
      expect { calculator.send(:check_for_integer_string, 'abc') }.to raise_error(ArgumentError, 'string has non integer value.')
    end

    it 'should raise an error for a string with only whitespace' do
      expect { calculator.send(:check_for_integer_string, ' ') }.to raise_error(ArgumentError, 'string has non integer value.')
      expect { calculator.send(:check_for_integer_string, "\t") }.to raise_error(ArgumentError, 'string has non integer value.')
      expect { calculator.send(:check_for_integer_string, "\n") }.to raise_error(ArgumentError, 'string has non integer value.')
    end
  end

  describe '#extract_delimiter_and_numbers' do
    it 'returns the numbers with default delimiters' do
      expect(calculator.send(:extract_delimiter_and_numbers, '1,2,3')).to eq('1,2,3')
      expect(calculator.send(:extract_delimiter_and_numbers, '1\n2,3')).to eq('1\n2,3')
    end

    it 'returns the numbers with custom single character delimiter' do
      expect(calculator.send(:extract_delimiter_and_numbers, "//;\n1;2;3")).to eq('1,2,3')
      expect(calculator.send(:extract_delimiter_and_numbers, "//#\n1#2#3")).to eq('1,2,3')
    end
  end
end
