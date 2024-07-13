require_relative '../string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  
  describe "#add" do
    it "returns 0 for an empty string" do
      puts "calculator.add: #{calculator.add("")}"
      expect(calculator.add("")).to eq(0)
    end
  end
end
