require_relative "00_tree_node"

class KnightPathFinder
  POSSIBLE_MOVES = [
    [1, 2], [1, -2], [-1, -2], [-1, 2], [2, 1], [2, -1], [-2, -1], [-2, 1]
  ]

  def initialize(pos)
    @root_node = pos
    @visited_positions = [pos]
  end

  def build_move_tree(root_node)
    move_queue = [root_node]
    node = PolyTreeNode.new(move_queue.first)
    until move_queue.empty?
      val_move = new_move_positions(move_queue.first)
      val_move.each do |move|
        child_node = PolyTreeNode.new(move)
        node.add_child(child_node)
        move_queue << child_node
      end
      move_queue.shift
    end
  end

  def self.valid_moves(pos)
    valid_arr = []
    POSSIBLE_MOVES.each do |move|
      valid_arr << KnightPathFinder.move_pos(pos, move)
    end

    valid_arr.select do |position|
      position.all?{ |idx| (1..7).cover?(idx) }
    end
  end

  def new_move_positions(pos)
    unvisited_move = KnightPathFinder.valid_moves(pos).reject do |position|
      @visited_positions.include?(pos)
    end
    @visited_positions += unvisited_move
    unvisited_move
  end

  def self.move_pos(pos, pos2)
    moves = Array.new(2)
    moves.first, moves.last = pos.first + pos2.first, pos.last + pos2.last
    moves
  end
end
