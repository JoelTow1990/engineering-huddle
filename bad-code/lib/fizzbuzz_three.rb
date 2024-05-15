class FizzBuzzThree
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


# Concise, declarative, readable, easy to change and extensible