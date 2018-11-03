require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(key, @prc)
    else
      add_uncached_key!(key)
    end

  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def add_uncached_key!(key, &prc)
    # suggested helper method; insert an (un-cached) key
    unless @map.include?(key)
      @store.append(key, prc.call(key))

      node = Node.new(key, prc.call(key))
      @map.set(key, node)
    end
  end

  def update_node!(key)
    # suggested helper method; move a node to the end of the list
    if @map.include?(key)
      current_node = @map.get(key)

      prev_node = current_node.prev
      next_node = current_node.next

      prev_node.next = next_node
      next_node.prev = prev_node

      @map.append(key, nil)
    end
  end

  def eject!
      head = @store.head
      first_node = head.next
      next_node = first_node.next
      head.next = next_node
      next_node.prev = head
  end
end
