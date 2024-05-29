require "rubocop"

# this class represents two players with their symbols
class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

# this class represents tic tac toe game and will initialize grid and turns for each player
class Game
  def initialize
    @grid_arr = Array.new(9, "$")
    @grid_arr[0] = " #{@grid_arr[0]}"
    9.times do |x|
      @grid_arr[x] = "#{@grid_arr[x]}\n" if ((x + 1) % 3).zero?
    end
    @player_choice_arr = []
  end

  def turn(player)
    getting_user_choice
    making_grid(player)
    p @player_choice_arr
    puts @grid_arr.join(" ").chomp
  end

  def getting_user_choice
    loop do
      puts "please enter your position of choice between 1-9"
      @player_choice = gets.chomp.to_i
      if !@player_choice_arr.include?(@player_choice) && (@player_choice >= 1 && @player_choice <= 9)
        @player_choice_arr.push(@player_choice)
        break
      end
    end
  end

  def making_grid(player)
    @grid_arr[@player_choice - 1] =
      if @player_choice == 1
        " #{player.symbol}"
      elsif (@player_choice % 3).zero?
        "#{player.symbol}\n"
      else
        player.symbol
      end
  end
end

# this class will be used to start the game
class TicTacToe < Game
  def start(player1, player2)
    9.times do |i|
      if (i % 2).zero?
        turn(player1)
      else
        turn(player2)
      end
    end
  end
end

player1 = Player.new("X")
player2 = Player.new("0")
game = TicTacToe.new
game.start(player1, player2)
