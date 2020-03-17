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

  def my_inject(p_one = nil, p_two = nil)
    arr = is_a?(Array) ? self : to_a
    sym = p_one if p_one.is_a?(Symbol) || p_one.is_a?(String)
    acc = p_one if p_one.is_a? Integer

    if p_one.is_a?(Integer)
      if p_two.is_a?(Symbol) || p_two.is_a?(String)
        sym = p_two
      elsif !block_given?
        raise "#{p_two} is not a symbol nor a string"
      end
    elsif p_one.is_a?(Symbol) || p_one.is_a?(String)
      raise "#{p_two} is not a symbol nor a string" if !p_two.is_a?(Symbol) && !p_two.nil?

      raise "undefined method `#{p_two}' for :#{p_two}:Symbol" if p_two.is_a?(Symbol) && !p_two.nil?
    end

    if sym
      arr.my_each { |curr| acc = acc ? acc.send(sym, curr) : curr }
    elsif block_given?
      arr.my_each { |curr| acc = acc ? yield(acc, curr) : curr }
    else
      raise 'no block given'
    end
    acc
  end

  def multiply_els(arr)
    arr.my_inject { |acc, curr| acc * curr }
  end
end

a = Hash["A" => 1, "B" => 2, "C" => 3]
b = a.to_a
p b[1]

