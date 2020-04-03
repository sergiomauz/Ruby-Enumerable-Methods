# rubocop: disable Layout/LineLength, Style/SymbolProc
require_relative '../enumerable.rb'

RSpec.describe Enumerable do
  array_numbers = [1, 5, 9, 8, 7, 3, 4, 6]
  hash_numbers = { 'a' => 3, 'b' => 7, 'c' => 9, 'd' => 8, 'e' => 6, 'f' => 2 }
  array_classes = %i[foo bar]
  mixing_values = [nil, true, 99]
  regular_expression = /t/
  strings_array = %w[ant bear cat]
  empty_array = []

  array_numbers_select = array_numbers.select { |num| num.even? }
  hash_numbers_select = hash_numbers.select { |key, val| val.even? && key.class == String }
  array_classes_select = array_classes.select { |val| val == :foo }
  array_numbers_all = array_numbers.all?(Numeric)
  mixing_values_all = mixing_values.all?
  strings_array_all = strings_array.all?(regular_expression)
  empty_array_all = empty_array.all?
  array_numbers_any = array_numbers.any?(Numeric)
  mixing_values_any = mixing_values.any?
  strings_array_any = strings_array.any?(regular_expression)
  empty_array_any = empty_array.any?

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
      expect(array_numbers.my_select { |num| num.even? }).to eql(array_numbers_select)
    end

    it 'If we pass a hash with a block, it will return the filter according to the condition of the block' do
      expect(hash_numbers.my_select { |key, val| val.even? && key.class == String }).to eql(hash_numbers_select)
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

  describe '#my_all?' do
    it 'if all elements in an array are true in comparison to the block condition, the method returns TRUE, else FALSE' do
      expect(array_numbers.my_all?(Numeric)).to eql(array_numbers_all)
    end

    it 'If the block is not given for a hash or array, it returns TRUE when none of the collection members are false or nil' do
      expect(mixing_values.my_all?).to eql(mixing_values_all)
    end

    it 'If the block is not given for a regular expression, it returns TRUE if all elements in the array match with the pattern' do
      expect(strings_array.my_all?(regular_expression)).to eql(strings_array_all)
    end

    it 'If the block is not given for an empty array, it returns TRUE' do
      expect(empty_array.my_all?).to eql(empty_array_all)
    end
  end

  describe '#my_any?' do
    it 'if an element in an array is true in comparison to the block condition, the method returns TRUE, else FALSE' do
      expect(array_numbers.my_any?(Numeric)).to eql(array_numbers_any)
    end

    it 'If the block is not given for a hash or array, it returns TRUE if at least one of the collection members is not false or nil.' do
      expect(mixing_values.my_any?).to eql(mixing_values_any)
    end

    it 'If the block is not given for a regular expression, it returns TRUE if one of the element in the array match with the pattern' do
      expect(strings_array.my_any?(regular_expression)).to eql(strings_array_any)
    end

    it 'If the block is not given for an empty array, it returns FALSE' do
      expect(empty_array.my_any?).to eql(empty_array_any)
    end
  end
end
# rubocop: enable Layout/LineLength, Style/SymbolProc
