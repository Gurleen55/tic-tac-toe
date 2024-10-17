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
  end
end
