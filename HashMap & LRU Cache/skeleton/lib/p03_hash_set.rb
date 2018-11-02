class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key] << key
      @count += 1
    end

    resize! if @count > num_buckets

  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  def my_each(&prc)
    @store.each do |bucket|
      bucket.each {|el| prc.call(el)}
    end
    self
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
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
    elements = []
    self.my_each do |el|
      elements << el
    end
    elements
  end

end
