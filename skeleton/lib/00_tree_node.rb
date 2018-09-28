class PolyTreeNode
  attr_reader :value
  attr_accessor :children, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
end
