# Tests.rb
require_relative '../enumerable.rb'

RSpec.describe Enumerable do
  array_numbers = [1, 5, 9, 8, 7, 3, 4, 6]
  hash_numbers = { 'a' => 3, 'b' => 7, 'c' => 9, 'd' => 8, 'e' => 6, 'f' => 2 }
  array_classes = [:foo, :bar]

  array_numbers_select = array_numbers.select { |num|  num.even? }
  hash_numbers_select = hash_numbers.select { |key, val|  val.even? }
  array_classes_select = array_classes.select { |val| val == :foo }


  describe '#my_each' do
    it 'If we pass an array with a block, it will returns the same array' do
      expect(array_numbers.my_each {}).to eql(array_numbers)
    end

    it 'If we pass a hash with a block, it will returns the same hash' do
      expect(hash_numbers.my_each {}).to eql(hash_numbers)
    end

    it 'If we pass an array without a block, it will returns a kind of Enumerator' do
      expect(array_numbers.my_each).to be_kind_of(Enumerator)
    end

    it 'If we pass hash without a block, it will returns a kind of Enumerator' do
      expect(hash_numbers.my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'If we pass an array with a block, it will returns the same array' do
      expect(array_numbers.my_each_with_index {}).to eql(array_numbers)
    end

    it 'If we pass a hash with a block, it will returns the same hash' do
      expect(hash_numbers.my_each_with_index {}).to eql(hash_numbers)
    end

    it 'If we pass an array without a block, it will returns a kind of Enumerator' do
      expect(array_numbers.my_each_with_index).to be_kind_of(Enumerator)
    end

    it 'If we pass hash without a block, it will returns a kind of Enumerator' do
      expect(hash_numbers.my_each_with_index).to be_kind_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'If we pass an array with a block, it will return the filter according to the condition of the block' do
      expect(array_numbers.my_select { |num|  num.even?  }).to eql(array_numbers_select)
    end

    it 'If we pass a hash with a block, it will return the filter according to the condition of the block' do
      expect(hash_numbers.my_select { |key, val|  val.even?  }).to eql(hash_numbers_select)
    end

    it 'If we pass an array of objects with a block, it will return the filter according to the condition of the block' do
      expect(array_classes.my_select { |val| val == :foo }).to eql(array_classes_select)
    end      

    it 'If we pass hash without a block, it will returns a kind of Enumerator' do
      expect(hash_numbers.my_select).to be_kind_of(Enumerator)
    end
    
    it 'If we pass an array without a block, it will returns a kind of Enumerator' do
      expect(array_numbers.my_select).to be_kind_of(Enumerator)
    end    
  end
end
