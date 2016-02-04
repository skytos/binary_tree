class Node
  include Enumerable
  attr_reader :key, :left, :right
  def initialize(key)
    @key = key
  end

  def insert(other_key)
    if other_key < key
      if left
        left.insert(other_key)
      else
        @left = self.class.new(other_key)
      end
    else
      if right
        right.insert(other_key)
      else
        @right = self.class.new(other_key)
      end
    end
  end

  def each(&b)
    left.each(&b) if left
    yield key
    right.each(&b) if right
  end

  def include?(search)
    if search == key
      true
    elsif search < key
      !!left && left.include?(search)
    else
      !!right && right.include?(search)
    end
  end
end
