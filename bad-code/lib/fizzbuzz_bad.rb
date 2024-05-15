class FizzBuzz
  def self.convert(n)
    res = ''

    if n % 3 == 0
      res += 'Fizz'
    end
    if n % 5 == 0
      res += 'Buzz'
    end

    res.empty? ? n.to_s : res
  end
end

p FizzBuzz.convert(3)
p FizzBuzz.convert(5)
p FizzBuzz.convert(7)
p FizzBuzz.convert(15)

# Values hardcoded into function
# If we want to add factors we have to keep adding if statements
# Violation of dry with repeated logic
# Only one function to test