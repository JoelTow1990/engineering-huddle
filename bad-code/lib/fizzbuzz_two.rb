class FizzBuzzTwo
  FACTOR_SOUND_MAPPING = {
    3 => "Fizz",
    5 => "Buzz",
  }

  def self.convert(n)
    res = ''
    FACTOR_SOUND_MAPPING.each do |factor, sound|
      res += check_factor(n, factor, sound)
    end

    res.empty? ? n.to_s : res
  end

  def self.check_factor(n, m, str)
    n % m == 0 ? str : ''
  end
end


# Factored out logic, no violation of dry
# More extensible because of hash instead of hardcoded values
# Technically more testable, though I would argue check factor is a private method and we shouldn't test it