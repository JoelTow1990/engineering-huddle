# spec/monte_carlo_spec.rb
require_relative '../lib/monte_carlo'

RSpec.describe MonteCarlo do
  let(:game) { Game.new(0.5) }
  let(:rounds) { rand(1..1_000) }
  
  describe "MonteCarlo will simulate n rounds of a Game" do
    context "The strategy is Constant" do
      let(:strategy) { Constant.new }
      let(:monte_carlo) { MonteCarlo.new(rounds, game, strategy) }

      it "returns an integer reward after arbitrarily many rounds" do
        expect(monte_carlo.simulate).to be_a(Integer)
      end
    end

    context "The strategy is Martingale" do
      let(:strategy) { Martingale.new }
      let(:monte_carlo) { MonteCarlo.new(rounds, game, strategy) }

      it "returns an integer reward after arbitrarily many rounds" do
        expect(monte_carlo.simulate).to be_a(Integer)
      end
    end

    context "the instance objects are called n times, where rounds = n" do
      let(:game) { instance_double(Game, play: 1) }
      let(:strategy) { instance_double(Constant, determine_bet: 1) }
      let(:monte_carlo) { MonteCarlo.new(rounds, game, strategy) }
      
      it 'calls game.play rounds number of times' do
        expect(game).to receive(:play).exactly(rounds).times
        monte_carlo.simulate
      end

      it 'calls strategy.determine_bet rounds number of times' do
        expect(strategy).to receive(:determine_bet).exactly(rounds).times
        monte_carlo.simulate
      end
    end
  end
end

RSpec.describe Game do
  context "When the win probability is 1" do
    let(:game) { Game.new(1) }
    let(:reward) { 1 }

    it "always returns a positive reward when the bet is positive" do
      expect(game.play(1)).to be(reward)
    end
  end

  context "When the win probability is 0" do
    let(:game) { Game.new(0) }
    let(:loss) { -1 }

    it "always returns a negative reward when the bet is positive" do
      expect(game.play(1)).to be(loss)
    end
  end
end

RSpec.describe Strategy do
  describe "strategy is an abstract class" do
    let(:strategy) { Strategy.new }

    it "raises NotImplementedError" do
      expect { strategy.determine_bet(0) }.to raise_error(NotImplementedError)
    end
  end
end

RSpec.describe Constant do
  describe "Constant strategy always returns a single unit" do
    let(:constant_strategy) { Constant.new }
    let(:round) { rand(1..1_000_000_000) }

    it "returns 1 regardless of round" do
      expect(constant_strategy.determine_bet(round)).to eq(1)
    end
  end
end

RSpec.describe Martingale do
  describe "Martingale strategy always doubles bet of previous round" do
    let(:martingale_strategy) { Martingale.new }

    it "returns a bet doubling with each round" do
      expect(martingale_strategy.determine_bet(0)).to eq(1)
      expect(martingale_strategy.determine_bet(1)).to eq(2)
      expect(martingale_strategy.determine_bet(2)).to eq(4)
    end
  end
end
