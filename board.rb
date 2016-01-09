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

  attr_reader :grid

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

  def find_tile_pos(tile)
    (0...8).each do |row|
      (0...8).each do |col|
        return [row,col] if self[[row,col]] == tile
      end
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
      unless current_tile.bomb
        current_tile.reveal_tile
        current_pos = find_tile_pos(current_tile)
        self.assign_children(current_pos) # add children to current_tile
        current_tile.children.each do |child|
          queue.push(child)
        end
      end
    end

  end

    # unless current_tile.revealed
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

    if bombs > 0
      self[pos].set_value(bombs)
      return
    end


    children = possible_moves(pos).select do |child_pos|
      self[child_pos].flagged == false && self[child_pos].revealed == false
    end

    children.each do |kid|
      self[pos].add_child(self[kid])
    end
  end

  def display
    @grid
    # display = Array.new(9) {Array.new(9) }
    # display.flatten.each_with_index do |pos, index|
    #   display[index] = @grid.flatten[index].value
    # end
    # display
  end

end





      # pos = []
# array.each_with_index do |row, row_index|
  # if row.include?(tile)
  #   pos << row_index
  #   row.each_with_index do |tile, col_idx|
  #     if tile == tile
