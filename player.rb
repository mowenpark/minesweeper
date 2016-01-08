class Player

  attr_reader :name, :guess

  def initialize(name)
    @name = name
  end


  def get_input
    @guess = gets.chomp
  end

end
