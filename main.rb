require_relative "lib/game"
player1 = Player.new("X", "Adam")
player2 = Player.new("O", "Eve")
game = TicTacToe.new
game.start(player1, player2)