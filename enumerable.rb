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
      my_each { |v|
        items_selected << v if yield(v)
      }      
    else
      items_selected = Hash[]
      my_each { |k, v|
        items_selected[k] = v if yield(k, v)
      }      
    end
    items_selected
  end

  def my_all?
    answer = true
    my_each { |v|
      unless yield(v)
        answer = false
        break
      end
    }
    answer
  end

  def my_any?
    answer = false
    my_each { |v|
      if yield(v)
        answer = true
        break
      end
    }
    answer
  end

  
end




