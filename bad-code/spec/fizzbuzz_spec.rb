require_relative "../lib/fizzbuzz_one"
require_relative "../lib/fizzbuzz_two"
require_relative "../lib/fizzbuzz_three"

RSpec.describe 'Fizzbuzz implementations' do
  def generate_divisible_by_n(n)
    numbers = []
    1000.times do
      random_number = rand(1..10000)
      random_number *= n
      numbers << random_number
    end
    numbers
  end

  def generate_not_divisible
    numbers = []
    while numbers.length < 1000 do
      random_number = rand(1..100000)
      numbers << random_number unless random_number % 3 == 0 || random_number % 5 == 0
    end
    numbers
  end

  let(:divisible_by_three) { generate_divisible_by_n(3) }
  let(:divisible_by_five) { generate_divisible_by_n(5) }
  let(:divisible_by_both) { generate_divisible_by_n(15) }
  let(:divisible_by_neither) { generate_not_divisible }

  describe FizzBuzzOne do
    describe 'it is a bad implementation, but it works' do
      it 'prefixes the result with Fizz when divisible by 3' do
        divisible_by_three.each do |n|
          expect(FizzBuzzOne.convert(n)).to start_with('Fizz')
        end
      end

      it 'postfixes the result with Buzz when divisible by 5' do
        divisible_by_five.each do |n|
          expect(FizzBuzzOne.convert(n)).to end_with('Buzz')
        end
      end

      it 'returns FizzBuzz when divisible by both' do
        divisible_by_both.each do |n|
          expect(FizzBuzzOne.convert(n)).to eq('FizzBuzz')
        end
      end

      it 'returns the input cast to a string when divisible by neither' do
        divisible_by_neither.each do |n|
          expect(FizzBuzzOne.convert(n)).to eq(n.to_s)
        end
      end
    end
  end

  describe FizzBuzzTwo do
    describe 'it is a better implementation than one' do
      it 'prefixes the result with Fizz when divisible by 3' do
        divisible_by_three.each do |n|
          expect(FizzBuzzTwo.convert(n)).to start_with('Fizz')
        end
      end
    
      it 'postfixes the result with Buzz when divisible by 5' do
        divisible_by_five.each do |n|
          expect(FizzBuzzTwo.convert(n)).to end_with('Buzz')
        end
      end
    
      it 'returns FizzBuzz when divisible by both' do
        divisible_by_both.each do |n|
          expect(FizzBuzzTwo.convert(n)).to eq('FizzBuzz')
        end
      end
    
      it 'returns the input cast to a string when divisible by neither' do
        divisible_by_neither.each do |n|
          expect(FizzBuzzTwo.convert(n)).to eq(n.to_s)
        end
      end  
    end
  end

  describe FizzBuzzThree do
    describe 'it is my preferred implementation' do
      it 'prefixes the result with Fizz when divisible by 3' do
        divisible_by_three.each do |n|
          expect(FizzBuzzThree.convert(n)).to start_with('Fizz')
        end
      end
    
      it 'postfixes the result with Buzz when divisible by 5' do
        divisible_by_five.each do |n|
          expect(FizzBuzzThree.convert(n)).to end_with('Buzz')
        end
      end
    
      it 'returns FizzBuzz when divisible by both' do
        divisible_by_both.each do |n|
          expect(FizzBuzzThree.convert(n)).to eq('FizzBuzz')
        end
      end
    
      it 'returns the input cast to a string when divisible by neither' do
        divisible_by_neither.each do |n|
          expect(FizzBuzzThree.convert(n)).to eq(n.to_s)
        end
      end 
    end
  end
end