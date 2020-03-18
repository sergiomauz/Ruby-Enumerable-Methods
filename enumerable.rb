# Enumerable methods
module Enumerable
  def my_each(&codeb)
    if block_given?
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
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index(&codeb)
    if block_given?
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
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
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
    else
      to_enum(:my_select)
    end
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
    eval_array = is_a?(Array) ? self : to_a

    if p_one.nil? && p_two.nil?
      sym = nil
      memo_accumulator = nil
    elsif !p_one.nil? && p_two.nil?
      p_one.is_a?(Symbol) ? sym = p_one : memo_accumulator = p_one
    elsif !p_one.nil? && !p_two.nil?
      memo_accumulator = p_one
      sym = p_two
    else
      raise "Undefined method `#{p_two}' for nil:NilClass"
    end

    if !sym.nil?
      eval_array.my_each { |v| memo_accumulator = memo_accumulator ? memo_accumulator.send(sym, v) : v }
    elsif block_given?
      eval_array.my_each { |v| memo_accumulator = memo_accumulator ? yield(memo_accumulator, v) : v }
    else
      raise 'no block given'
    end

    memo_accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |memo, val| memo * val }
end
