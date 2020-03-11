module Enumerable
    def my_each
            i = 0
            while i < self.length
                yield(self[i])
                i+=1
            end
    end
    
    def my_each_with_index
            i = 0
            while i < self.length
                yield(i, self[i])
                i += 1
            end
    end

    def my_select       
       
    end

    def my_all?()

    end

    def my_any?()

    end

    def my_none?()

    end

    def my_count()

    end

    def my_map()

    end

    def my_inject()

    end

    def multiply_els()

    end
end

