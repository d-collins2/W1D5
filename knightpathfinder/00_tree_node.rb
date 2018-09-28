require "byebug"

class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    unless parent_node.nil? || parent_node.children.include?(self)
      parent_node.children << self
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "This node was not a child." unless children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value
    children.each do |child|
      child_dfs = child.dfs(target_value)
      unless child_dfs.nil?
        return child_dfs
      end
    end
    nil
  end

  def bfs(target_value)

    queue = [self]

    until queue.empty?

      first = queue.shift
      queue += first.children
      return first if target_value == first.value
    end
    nil
  end


end
