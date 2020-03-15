# Enumerable methods
module Enumerable
  def my_each(&codeb)
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      if is_a?(Array)
        yield(self[i])
      elsif codeb.arity == 1
        yield(assoc keys[i])
      else
        yield(keys[i], self[keys[i]])
      end
      i += 1
    end
    self
  end

  def my_each_with_index(&codeb)
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      if is_a?(Array)
        yield(self[i], i)
      elsif codeb.arity == 1
        yield(assoc keys[i])
      else
        yield([keys[i], self[keys[i]]], i)
      end
      i += 1
    end
    self
  end

  def my_select
    if is_a?(Array)
      new_array = []
      my_each do |v|
        new_array << v if yield(v)
      end
      new_array
    else
      new_hash = Hash[]
      my_each do |k, v|
        new_hash[k] = v if yield(k, v)
      end
      new_hash
    end
  end
end
