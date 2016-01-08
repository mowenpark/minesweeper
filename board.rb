class Board

  NEIGHBORS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [-1,-1]
  ]

  def initialize
    @grid = Array.new(9) {Array.new(9) {Tile.new}}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def populate(bombs = 10)
    @grid.flatten.sample(bombs).each do |tile|
      tile.set_bomb # sets bomb to true
    end
  end

  def reveal(pos)
    return "bomb" if self[pos].bomb == true
    self[pos].reveal_tile
  end

  def bfs(pos)
    queue = [self[pos]]

    current_tile = queue.shift

    unless current_tile.revealed
      

  end

  def possible_moves(pos)
    valid_moves = []

    cur_row, cur_col = pos

    NEIGHBORS.each do |dx, dy|
      new_neighbor = [cur_row+dx, cur_col+dy]

      if new_neighbor.all? { |coord| coord.between?(0, 8) }
        valid_moves << new_neighbor
      end
    end

    valid_moves
  end



  def display

  end

end
