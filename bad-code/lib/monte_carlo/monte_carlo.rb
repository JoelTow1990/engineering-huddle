class MonteCarlo
  attr_reader :game, :strategy
  
  def initialize(game, strategy)
    @game = game
    @strategy = strategy
  end

  def simulate(rounds)
    rewards = 0
    rounds.times do |round|
      rewards += game.play(strategy.determine_bet(round))
    end
    rewards
  end
end

class Game
  def initialize(win_probability)
    @win_probability = win_probability
  end

  def play(bet)
    rand(0.0..1.0) <= @win_probability ? bet : -bet
  end
end

class Strategy 
  def determine_bet(round)
    raise NotImplementedError
  end
end

class Constant < Strategy
  def determine_bet(round)
    1
  end
end

class Martingale < Strategy
  def determine_bet(round)
    2 ** round
  end
end
