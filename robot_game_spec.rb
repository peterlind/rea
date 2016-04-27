require "./robot_game"
describe RobotGame do
  N = "NORTH".freeze
  S = "SOUTH".freeze
  W = "WEST".freeze
  E = "EAST".freeze

  let(:game) { RobotGame.new }

  context "placement" do
    it "accepts placement" do
      game.place(0, 0, N)
      expect(game.report).to eq([0, 0, N])
    end
    it "makes placement outside 5x5 grid a noop" do
      game.place(0, 0)
      expect(game.report).to eq([0, 0, N])
      game.place(-1, 0)
      expect(game.report).to eq([0, 0, N])
      game.place(5, 0)
      expect(game.report).to eq([0, 0, N])
      game.place(0, -2)
      expect(game.report).to eq([0, 0, N])
    end
    it "makes placement in invalid direction a noop" do
      game.place(0, 0)
      expect(game.report).to eq([0, 0, N])
      game.place(0, 0, 'NORTHWEST')
      expect(game.report).to eq([0, 0, N])
      game.place(0, 0, 'GARBLEGARBLE')
      expect(game.report).to eq([0, 0, N])
    end
    it "accepts valid direction parameter" do
      %w(NORTH SOUTH EAST WEST).each do |direction|
        game.place(0, 0, direction)
        expect(game.report).to eq([0, 0, direction])
      end
    end
    it "reports x, y and direction after placement" do
      game.place(1, 2, S)
      expect(game.report).to eq([1, 2, S])
    end
  end

  context "command sequence" do
    it "is a noop to issue a command before placement" do
      expect(game.report).to eq(nil)
    end
  end

  context "moving" do
    it "accepts movement within grid" do
      game.place(0, 0, N)
      game.move
      expect(game.report).to eq([0, 1, N])

      game.place(0, 0, E)
      game.move
      expect(game.report).to eq([1, 0, E])
    end
    it "does nothing is movement would put robot off grid" do
      game.place(0, 0, S)
      game.move
      expect(game.report).to eq([0, 0, S])

      game.place(0, 0, W)
      game.move
      expect(game.report).to eq([0, 0, W])
    end
  end

  context "turning" do
    it "changes direction after left/right command" do
      game.place(0, 0, N)
      game.left
      expect(game.report).to eq([0, 0, W])

      game.right
      expect(game.report).to eq([0, 0, N])

      game.right
      expect(game.report).to eq([0, 0, E])

      game.left
      game.left
      game.left
      expect(game.report).to eq([0, 0, S])
      game.left
      expect(game.report).to eq([0, 0, E])

      game.right
      expect(game.report).to eq([0, 0, S])
      game.right
      expect(game.report).to eq([0, 0, W])
      game.right
      game.right
      expect(game.report).to eq([0, 0, E])
    end
  end

  context "game examples" do
    it "passes example a" do
      game.place(0, 0, N)
      game.move
      expect(game.report).to eq([0, 1, N])
    end
    it "passes example b" do
      game.place(0, 0, N)
      game.left
      expect(game.report).to eq([0, 0, W])
    end
    it "passes example c" do
      game.place(1, 2, E)
      game.move
      game.move
      game.left
      game.move
      expect(game.report).to eq([3, 3, N])
    end
  end
end
