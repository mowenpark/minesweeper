class Game

  def initialize(player_name)
    @player = Player.new(player_name)
    @board = Board.new

  end

  def play
    @board.reveal
  end

  def bfs
  end

end
