require_relative "../lib/main"

describe TicTacToe do
  describe "#check_winner" do
    context "when one of the player has met winning conditions on first horizontal line" do
      let(:player1) { instance_double(Player, symbol: "X", name: "Gurleen") }
      before do
        subject.instance_variable_set(:@grid_arr, [%w[X X X]])
      end

      it "ends game and declares that player the winner" do
        expect(subject.check_winner(player1)).to eql(true)
      end
    end

    context "when one of the player has met winning conditions on first vertical line" do
      let(:player1) { instance_double(Player, symbol: "X", name: "Gurleen") }
      before do
        subject.instance_variable_set(:@grid_arr, [%w[X X Y], %w[X X Y], %w[X Y X]])
      end

      it "ends game and declares that player the winner" do
        expect(subject.check_winner(player1)).to eql(true)
      end
    end
  end

  describe "#get_user_choice" do
    let(:player) { instance_double(Player, name: "Gurleen") }
    context "when user enters a valid input" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4")
        allow(subject).to receive(:valid_choice?).with(4).and_return(true)
      end
      it "assigns input to choice variable and doesn't output (Invalid choice, please try again)" do
        expect(subject).not_to receive(:puts).with("Invalid choice, please try again")
        subject.get_user_choice(player)
        expect(subject.instance_variable_get(:@player_choice)).to eql(4)
      end
    end

    context "when user enters one invalid input and then valid" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("10", "4")
        allow(subject).to receive(:valid_choice?).with(10).and_return(false)
        allow(subject).to receive(:valid_choice?).with(4).and_return(true)
      end
      it "outputs 'Invalid choice, please try again'" do
        expect(subject).to receive(:puts).with("Invalid choice, please try again")
        subject.get_user_choice(player)
        expect(subject.instance_variable_get(:@player_choice)).to eql(4)
      end
    end
  end

  describe "#position_to_indices" do
    context "when player enter 1" do
      it "returns co-ordinates [0,0]" do
        result = subject.position_to_indices(1)
        expect(result).to eql([0, 0])
      end
    end
    context "when player enter 8" do
      it "returns co-ordinates [2,2]" do
        result = subject.position_to_indices(8)
        expect(result).to eql([2, 1])
      end
    end
    context "when player enter 8" do
      it "returns co-ordinates [2,2]" do
        result = subject.position_to_indices(8)
        expect(result).to eql([2, 1])
      end
    end
  end

  describe "#valid_choice?" do
    context "when player chooses a number between 1 - 9" do
      it "returns true" do
        expect(subject).to be_valid_choice(3)
      end
    end
    context "when player chooses a number other than 1 - 9" do
      it "returns false" do
        expect(subject.valid_choice?(11)).to be false
      end
    end
    context "when player chooses a non-number" do
      it "returns false" do
        # since choice will be coverted to integer everytime
        expect(subject.valid_choice?("xy".to_i)).to be false
      end
    end
    context "When player chooses an already chosen number" do
      let(:player) { instance_double(Player, symbol: "X") }
      before do
        subject.instance_variable_set(:@grid_arr, [["X"]])
      end
      it "returns false" do
        expect(subject.valid_choice?(1)).to be false
      end
    end
  end

  describe "#update_grid" do
    let(:player) { instance_double(Player, symbol: "X") }
    before do
      allow(subject).to receive(:position_to_indices).with(2).and_return([0, 1])
      subject.instance_variable_set(:@player_choice, 2)
    end
    it "updates the grid" do
      subject.update_grid(player)
      grid_arr = subject.instance_variable_get(:@grid_arr)
      expect(grid_arr[0][1]).to eql("X")
    end
  end

  describe "#start" do
    context "when one player wins the game" do
      let(:player1) { instance_double(Player, name: "Deadpool", symbol: "X") }
      let(:player2) { instance_double(Player, name: "Wolverine", symbol: "O") }
      before do
        allow(subject).to receive(:display_grid)
        allow(subject).to receive(:turn)
        allow(subject).to receive(:check_winner).and_return(false, false, true)
      end
      it "declares Deadpool winner" do
        expect(subject).to receive(:puts).with("Deadpool wins!").once
        subject.start(player1, player2)
      end
    end
    context "when neither of player wins the game" do
      let(:player1) { instance_double(Player, name: "Deadpool", symbol: "X") }
      let(:player2) { instance_double(Player, name: "Wolverine", symbol: "O") }
      before do
        allow(subject).to receive(:display_grid)
        allow(subject).to receive(:turn)
        allow(subject).to receive(:check_winner).and_return(false, false, false, false, false, false, false, false,
                                                            false)
      end
      it "declares a draw" do
        expect(subject).to receive(:puts).with("It's a Draw").once
        subject.start(player1, player2)
      end
    end
  end
end
