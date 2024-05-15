class FizzBuzzTwo
  FACTOR_SOUND_MAPPING = {
    3 => "Fizz",
    5 => "Buzz",
  }

  def self.convert(integer)
    result = ''
    FACTOR_SOUND_MAPPING.each do |factor, sound|
      result += check_factor(integer, factor, sound)
    end

    result.empty? ? integer.to_s : result
  end

  def self.check_factor(dividend, divisor, sound)
    dividend % divisor == 0 ? sound : ''
  end
end


# Factored out logic, no violation of dry
# More extensible because of hash instead of hardcoded values