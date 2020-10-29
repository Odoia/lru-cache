class Cache
  attr_accessor :cache, :max_count

  def initialize(max_count:)
    @max_count = max_count
    @cache = []
  end

  def write(key, value)
    if cache.count == max_count
      order_array = cache.sort_by { |c| c[:count] }
      if order_array[0][:count] == order_array[1][:count]
        value_to_search = order_array[0][:count]

        cache.each do |c|
          if c[:count] == value_to_search
            remove(c.keys.first)
            cache.push({ key.to_s => value, count: 0 })
            return
          end
        end
      else
        key_to_remove = order_array[0].keys.first
        remove(key_to_remove)
        cache.push({ key.to_s => value, count: 0 })
      end
    else
      cache.push({ key.to_s => value, count: 0 })
    end
  end

  def read(key)
    cache.each do |c|
      if c[key]
        c[:count] += 1
      end
    end
  end

  def remove(key)
    cache.each do |c|
      if c[key]
        cache.delete(c)
      end
    end
  end
end
