class MonteCarlo
  attr_reader :rounds, :game, :strategy
  def initialize(rounds, game, strategy)
    @rounds = rounds
    @game = game
    @strategy = strategy
  end

  def simulate
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
  
  # Some issues:
  # - Not dealing with temporal coupling
  # - Would benefit from caching previous bet and doubling it in Martingale
  # - Game assumes you either gain or lose your bet, but we could introduce
  #   more complex rule, like win_factor (e.g. 1/win_probality) and include
  #   this in our game
  # - Probably need to handle numerical overflow for Martingale