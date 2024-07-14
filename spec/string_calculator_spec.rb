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
  end
end
