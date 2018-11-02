require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
     bucket(key).include?(key)
  end

  def set(key, val)
   if include?(key)
     bucket(key).update(key, val)
   else
     bucket(key).append(key, val)
     @count += 1
   end

  resize! if @count > num_buckets

  end

  def get(key)
    return bucket(key).get(key) if include?(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |linkedlist|
      linkedlist.each do |node|
        yield(node.key, node.val)
      end
    end
  end


  def inspect
    self.each do |node|
      puts "Node k: #{node.key}"
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    
    elements = all_elements
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    @count = 0
    elements.each do |pair|
      set(pair.first, pair.last)
    end
  end

  def all_elements
    elements = []
    self.each do |k,v|
      elements << [k,v]
    end
    elements
  end

  def bucket(key)
    bucket_num = key.hash % num_buckets
    @store[bucket_num]
  end
end

if __FILE__ == $PROGRAM_NAME
  my_hash_map = HashMap.new(2)
  my_hash_map.set(1, 2)
  my_hash_map.set(3, 4)
  my_hash_map.set(5, 6)
end
