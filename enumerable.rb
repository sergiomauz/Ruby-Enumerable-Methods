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
        my_each do |item|
          items_selected.push(item) if yield(item)
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

  def my_all?(*args)
    answer = true
    if !args[0].nil?
      my_each do |item|
        unless args[0] == item
          answer = false
          break
        end
      end
    elsif block_given?
      my_each do |item|
        unless yield(item)
          answer = false
          break
        end
      end
    else
      my_each do |item|
        unless item
          answer = false
          break
        end
      end
    end
    answer
  end

  def my_any?(p_one = nil)
    answer = false
    if !p_one.nil?
      my_each do |item|
        if p_one.is_a?(Regexp)
          if item.match(p_one)
            answer = true
            break
          end
        elsif p_one == item || item.is_a?(p_one)
          answer = true
          break
        end
      end
    elsif block_given?
      my_each do |item|
        if yield(item)
          answer = true
          break
        end
      end
    else
      my_each do |item|
        if item
          answer = true
          break
        end
      end
    end
    answer
  end

  def my_none?(p_one = nil, &block)
    !my_any?(p_one, &block)
  end

  def my_count(p_one = nil)
    count = 0
    if p_one.nil? && block_given?
      my_each { |k| count += 1 if yield(k) }
    elsif !p_one.nil? && !block_given?
      my_each { |k| count += 1 if k == p_one }
    elsif !p_one.nil? && block_given?
      raise 'given block not used'
    else
      my_each { count += 1 }
    end

    count
  end

  def my_map(&proc)
    if block_given? && proc.arity <= 1
      new_array = []
      my_each do |item|
        new_array.push(yield(item))
      end
      new_array
    else
      to_enum(:my_map)
    end
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
      eval_array.my_each { |item| memo_accumulator = memo_accumulator ? memo_accumulator.send(sym, item) : item }
    elsif block_given?
      eval_array.my_each { |item| memo_accumulator = memo_accumulator ? yield(memo_accumulator, item) : item }
    else
      raise 'no block given'
    end

    memo_accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |memo, val| memo * val }
end
