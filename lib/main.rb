require "rubocop"

# this class represents two players with their symbols
class Player
  attr_accessor :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end

# this class represents tic tac toe game and will initialize grid and turns for each player
class Game
  def initialize
    @grid_arr = Array.new(3) { Array.new(3) { " " } }
    @player_choice_arr = []
  end

  def turn(player)
    get_user_choice(player)
    update_grid(player)
    display_grid
  end

  def get_user_choice(player)
    loop do
      puts "#{player.name}, please enter your position of choice between 1-9"
      choice = gets.chomp.to_i
      if valid_choice?(choice)
        @player_choice = choice
        break
      else
        puts "Invalid choice, please try again"
      end
    end
  end

  def valid_choice?(choice)
    return false unless choice.between?(1, 9)

    row, column = position_to_indices(choice)
    @grid_arr[row][column] == " "
  end

  def position_to_indices(position)
    row = (position - 1) / 3
    column = (position - 1) % 3
    [row, column]
  end

  def update_grid(player)
    row, column = position_to_indices(@player_choice)
    @grid_arr[row][column] = player.symbol
  end

  def display_grid
    @grid_arr.each_with_index do |row, index|
      puts row.map { |cell| cell.empty? ? " " : cell }.join(" | ")
      puts "--+---+---" unless index == @grid_arr.size - 1
    end
  end
end

# this class will be used to start the game
class TicTacToe < Game
  def start(player1, player2)
    display_grid
    9.times do |i|
      player = i.even? ? player1 : player2
      turn(player)
      if check_winner(player)
        puts "#{player.name} wins!"
        return
      end
    end
    puts "It's a Draw"
  end

  def check_winner(player)
    winning_positions.any? do |line|
      line.all? { |row, column| @grid_arr[row][column] == player.symbol }
    end
  end

  def winning_positions
    rows = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]]]
    columns = [[[0, 0], [1, 0], [2, 0]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]]]
    diagonals = [
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]]
    ]
    rows + columns + diagonals
  end
end

player1 = Player.new("X", "Gurleen")
player2 = Player.new("O", "Gurveen")
game = TicTacToe.new
game.start(player1, player2)
