require "./robot_game"
describe RobotGame do
  let(:game) { RobotGame.new }
  context "initial placement" do
    it "accepts placement" do
      game.place(0, 0, "NORTH")
      expect(game.report).to eq([0, 0, "NORTH"])
    end
    it "ensures placement is within 5x5 grid" do
      expect { game.place(0, 0) }.to_not raise_exception
      expect { game.place(4, 4) }.to_not raise_exception
      expect { game.place(-1, 0) }.to raise_exception(StandardError)
      expect { game.place(5, 0) }.to raise_exception(StandardError)
      expect { game.place(0, -2) }.to raise_exception(StandardError)
      expect { game.place(0, 5) }.to raise_exception(StandardError)
    end
    it "ensures valid direction parameter" do
      %w(NORTH SOUTH EAST WEST).each do |direction|
        expect { game.place(0, 0, direction) }.to_not raise_exception
      end
      expect { game.place(0, 0, "NORTHEAST") }.to raise_exception(StandardError)
      expect { game.place(0, 0, "GARBLE") }.to raise_exception(StandardError)
    end
    it "reports x, y and direction after placement" do
      game.place(1, 2, 'SOUTH')
      expect(game.report).to eq([1, 2, 'SOUTH'])
    end
  end
end
