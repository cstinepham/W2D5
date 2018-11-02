require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  def count
    @store.length
  end

  private

  def is_valid?(num)
    num < count && num >= 0 && num.is_a?(Fixnum)
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless @store[mod(num)].include?(num)
      @store[mod(num)].push(num)
    end
  end

  def remove(num)
    @store[mod(num)].delete(num)
  end

  def include?(num)
    @store[mod(num)].include?(num)
  end

  private

  # def [](num)
  #
  # end

  def mod(num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)

    unless include?(num)
      self[num].push(num)
      @count += 1
    end

    resize! if @count > num_buckets

  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def my_each(&prc)
    @store.each do |bucket|
      bucket.each {|el| prc.call(el)}
    end
    self
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = all_elements
    @store = Array.new(num_buckets * 2) {[]}
    @count = 0
    elements.each do |el|
      self.insert(el)
    end

    nil
  end

  def all_elements
    all_elements = []
    self.my_each do |el|
      all_elements << el
    end
    all_elements
  end

end

if __FILE__ == $PROGRAM_NAME
  my_set = ResizingIntSet.new(2)
  my_set.insert(1)
  my_set.insert(2)
  my_set.insert(3)

end
