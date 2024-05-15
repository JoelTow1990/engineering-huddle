class FizzBuzz
  FACTOR_SOUND_MAPPING = {
    3 => "Fizz",
    5 => "Buzz",
  }
  
  def self.convert(integer)
    factors = FACTOR_SOUND_MAPPING.keys.select { |divisor| integer % divisor == 0 }
    sounds = factors.map { |factor| FACTOR_SOUND_MAPPING[factor] }
    
    sounds.any? ? sounds.join : integer.to_s
  end
end

p FizzBuzz.convert(3)
p FizzBuzz.convert(5)
p FizzBuzz.convert(7)
p FizzBuzz.convert(15)

# Concise, declarative, readable, easy to change and extensible