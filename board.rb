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

  # def reveal(pos)
  #   return "bomb" if self[pos].bomb == true #end game if the tile is a bomb
  #   self[pos].reveal_tile
  # end

  def bfs(pos)
    queue = [self[pos]]

    until queue.empty?
      current_tile = queue.shift
      current_tile.reveal_tile

      current_tile
    end

    # unless current_tile.revealed


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

  def assign_children(pos)
    bombs = 0
    possible_moves(pos).each do |child_pos|
      if self[child_pos].bomb == true
        bombs += 1
      end
    end

    return self[pos].value = bombs if bombs > 0

    children = possible_moves(pos).select do |child_pos|
      self[child_pos].flagged == false && self[child_pos].revealed == false
    end

    children.each do |kid|
      self[pos].add_child(self[kid])
    end
  end

  def display

  end

end
