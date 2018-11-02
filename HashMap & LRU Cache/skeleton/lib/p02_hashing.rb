class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    result = self[0].hash
    self[1..-1].each do |el|
        result = result ^ el.hash
    end

    result
  end

end

class String
  def hash
    self.bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted_hash = self.sort_by { |k, v| k }

    result = sorted_hash.first.hash
    sorted_hash[1..-1].each do |pair|
      result = result ^ pair.hash
    end
    result
  end
end
