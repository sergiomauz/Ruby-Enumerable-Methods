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
    my_each do |item|
      if !args[0].nil?
        if args[0].is_a?(Regexp) 
          return false unless item.match(args[0]) 
        elsif args[0].is_a?(Class)          
          return false unless item.is_a?(args[0])
        else
          return false unless item == args[0]
        end                
      elsif block_given?
        return false unless yield(item)
      else
        return false unless item
      end
    end
    true
  end

  def my_any?(p_one = nil)
    my_each do |item|
      if !p_one.nil?
        if p_one.is_a?(Regexp) 
          return true if item.match(p_one) 
        elsif p_one.is_a?(Class)          
          return true if item.is_a?(p_one)
        else
          return true if item == p_one
        end                
      elsif block_given?
        return true if yield(item)
      else
        return true if item
      end
    end
    false
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

  def my_map(proc = nil)
    ary = is_a?(Array) ? self : to_a
    new_array = []

    if !proc.nil?
      ary.my_each { |item| new_array.push(proc.call(item)) }
    elsif block_given?
      ary.my_each { |item| new_array.push(yield(item)) }      
    else
      return to_enum(:my_map)
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
      eval_array.my_each { |item| memo_accumulator = memo_accumulator ? memo_accumulator.send(sym, item) : item }
    elsif block_given?
      eval_array.my_each { |item| memo_accumulator = memo_accumulator ? yield(memo_accumulator, item) : item }
    else
      raise 'no block given'
    end

    memo_accumulator
  end
end

def multiply_els(ary)
  ary.my_inject { |memo, val| memo * val }
end
