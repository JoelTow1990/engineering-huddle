class Roulette
  def initialize(win_p = 0.5)
    @win_p = win_p
  end

  def simulation(unit_size)
    random = rand(0.0..1.0)
    random <= @win_p ? unit_size : -unit_size
  end

  #make martingale method and track whether you win as input
  # or keep it as block but take the argument of whether bet won
  
  def monte_carlo(games = 1000, unit_size = 1.0, &strategy)
    reward = 0
    (1..games).each do |_|
      unit_size = strategy.call(unit_size)
      reward += simulation(unit_size)
    end
    reward
  end
end

constant = -> (unit) { unit }
martingale = -> (unit) { unit * 2 }

puts Roulette.new(18.0 / 37.0).monte_carlo(1000, 1.0, &martingale)
