# Constants
class Fair_ame
  attr_accessor :win_p
  def initialize(win_p = 0.5)
    @win_p = win_p
  end
  def expected_value
    win_p - (1 - win_p)
  end
  def simulation(unit_size)
    random = rand(0.0..1.0)
    if random <= win_p
      unit_size
    else
      -unit_size
    end
  end
  def monte_carlo(games=1000, unit_size=1.0, &strategy)
    reward = 0
    (1..games).each do |_|
      unit_size = strategy.call(unit_size)
      reward += simulation(unit_size)
    end
    reward
  end
  def constant_bet_strategy(unit_size)
    unit_size
  end
  def exponential_bet_strategy(unit_size)
    unit_size * 2.0
  end
  def aggregate_monte_carlo(runs=100000.0, games=1000, unit_size=1.0, &strategy)
    total = 0.0
    runs.times do |_|
      total += monte_carlo(games, unit_size, &strategy)
    end
    total / runs
  end
end

class Real_ame < Fair_ame
  def initialize(win_p = 18.0 / 37.0)
    super
  end
end

game = Fair_ame.new
puts "The expected value of a round in a fair game is #{game.expected_value}"
puts
result = game.aggregate_monte_carlo(50000, 1000, 1, &game.method(:constant_bet_strategy))
puts "Result of a fair game with constant bet: #{result}"
puts

result = game.aggregate_monte_carlo(50000, 1000, 1, &game.method(:exponential_bet_strategy))
puts "Result of a fair game with exponential bet: #{result}"
puts

game = Real_ame.new
puts "The expected value of a round in a real game is #{game.expected_value}"
puts
result = game.aggregate_monte_carlo(50000, 1000, 1, &game.method(:constant_bet_strategy))
puts "Result of a real game with constant bet: #{result}"
puts

result = game.aggregate_monte_carlo(50000, 1000, 1, &game.method(:exponential_bet_strategy))
puts "Result of a real game with exponential bet: #{result}"
