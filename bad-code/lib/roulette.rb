class Roulette

  def initialize(win_p = 0.5)
    @win_p = win_p
  end

  def simulation(unit_size)
    random = rand(0.0..1.0)
    random <= @win_p ? unit_size : -unit_size
  end
  
  def monte_carlo(games=1000, unit_size=1.0, &strategy)
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

# This Roulette class is not easy to test:
#   - No deterministic output for either method
#   
# The variable and method names are not informative:
#   - :game is probably more informative than :simulation
#   - random doesn't convey the purpose of the variable
#   - strategy names don't indicate their purpose
#
# Several responsibilities tied up in this class:
#   - Playing game (:simulation)
#   - Running Monte Carlo simulation (:monte_carlo)
#   - Applying the betting strategy