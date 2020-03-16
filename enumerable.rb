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
      items_selected = []
      my_each do |v|
        items_selected << v if yield(v)
      end
    else
      items_selected = Hash[]
      my_each do |k, v|
        items_selected[k] = v if yield(k, v)
      end
    end
    items_selected
  end

  def my_all?
    answer = true
    my_each do |v|
      unless yield(v)
        answer = false
        break
      end
    end
    answer
  end

  def my_any?
    answer = false
    my_each do |v|
      if yield(v)
        answer = true
        break
      end
    end
    answer
  end

  def my_none?
    answer = true
    my_each do |v|
      if yield(v)
        answer = false
        break
      end
    end
    answer
  end

  def my_count
    count = 0
    my_each do
      count += 1
    end
    count
  end

  def my_map
    new_array = []
    my_each do |v| 
      new_array.push(yield(v))
    end
    new_array
  end
end
