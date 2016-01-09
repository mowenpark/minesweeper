class Tile
  attr_reader :parent, :value, :revealed, :bomb, :flagged

  def initialize
    @bomb = false
    @revealed = false
    @value = nil
    @parent = nil
    @children = []
    @flagged = false
  end

  def children
    @children.dup
  end

  def set_bomb
    @bomb = true
  end

  def set_value(kid_bombs)
    @value = kid_bombs
  end

  def reveal_tile
    if @revealed == true || @flagged == true
      puts "Tile is already revealed or is flagged."
      return
    end
    @revealed = true

  end

  def parent=(new_parent)
    return if @parent == new_parent

    if self.parent
      self.parent._children.delete(self)
    end

    @parent = new_parent
    self.parent._children << self unless self.parent.nil?

    self
  end

  def add_child(new_child)
    new_child.parent = self
  end

  def remove_child(old_child)

    if old_child && !self.children.include?(old_child)
      raise "This tile is not a child"
    end
    # _children.delete(old_child) if _children.include?(old_child)
    old_child.parent = nil
  end

  # def inspect
  #   @bomb
  # end

  protected
  # Protected method to give a node direct access to another node's
  # children.
  def _children
    @children
  end

end
