require './node'

class Tree
  include Enumerable
  attr_reader :root

  def initialize
    @root = nil
  end  

  def insert(x)
    if @root
      @root.insert x
    else  
      @root = Node.new x
    end  
  end  

  def each(&b)
    if @root
      @root.each &b
    end  
  end  

  def include?(x)
    !!@root && @root.include?(x)
  end  
end
