class FizzBuzzOne
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


# Values hardcoded into function
# If we want to add factors we have to keep adding if statements
# Violation of dry with repeated logic