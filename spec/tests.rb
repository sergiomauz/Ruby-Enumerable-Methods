# rubocop: disable Layout/LineLength, Style/SymbolProc
require_relative '../enumerable.rb'

RSpec.describe Enumerable do
  let(:array_numbers) { [1, 5, 9, 8, 7, 3, 4, 6] }
  let(:regular_expression) { /t/ }
  let(:empty_array) { [] }
  let(:mixing_values) { [nil, true, 99] }
  let(:strings_array) { %w[ant bear cat] }
  let(:hash_numbers) { { 'a' => 3, 'b' => 7, 'c' => 9, 'd' => 8, 'e' => 6, 'f' => 2 } }
  let(:array_classes) { %i[foo bar] }

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
      expect(array_numbers.my_select { |num| num.even? }).to eql(array_numbers.select { |num| num.even? })
    end

    it 'If we pass a hash with a block, it will return the filter according to the condition of the block' do
      hash_numbers_select = hash_numbers.select { |key, val| val.even? && key.class == String }
      expect(hash_numbers.my_select { |key, val| val.even? && key.class == String }).to eql(hash_numbers_select)
    end

    it 'If we pass an array of objects with a block, it will return the filter according to the condition of the block' do
      expect(array_classes.my_select { |val| val == :foo }).to eql(array_classes.select { |val| val == :foo })
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
      expect(array_numbers.my_all?(Numeric)).to eql(array_numbers.all?(Numeric))
    end

    it 'If the block is not given for a hash or array, it returns TRUE when none of the collection members are false or nil' do
      expect(mixing_values.my_all?).to eql(mixing_values.all?)
    end

    it 'If the block is not given for a regular expression, it returns TRUE if all elements in the array match with the pattern' do
      strings_array_all = strings_array.all?(regular_expression)
      expect(strings_array.my_all?(regular_expression)).to eql(strings_array_all)
    end

    it 'If the block is not given for an empty array, it returns TRUE' do
      expect(empty_array.my_all?).to eql(empty_array.all?)
    end
  end

  describe '#my_any?' do
    it 'if an element in an array is true in comparison to the block condition, the method returns TRUE, else FALSE' do
      expect(array_numbers.my_any?(Numeric)).to eql(array_numbers.any?(Numeric))
    end

    it 'If the block is not given for a hash or array, it returns TRUE if at least one of the collection members is not false or nil.' do
      expect(mixing_values.my_any?).to eql(mixing_values.any?)
    end

    it 'If the block is not given for a regular expression, it returns TRUE if one of the element in the array match with the pattern' do
      strings_array_any = strings_array.any?(regular_expression)
      expect(strings_array.my_any?(regular_expression)).to eql(strings_array_any)
    end

    it 'If the block is not given for an empty array, it returns FALSE' do
      expect(empty_array.my_any?).to eql(empty_array.any?)
    end
  end

  describe '#my_none?' do
    it 'if all elements in an array are FALSE in comparison to the block condition, the method returns TRUE, else FALSE' do
      expect(array_numbers.my_none?(Numeric)).to eql(array_numbers.none?(Numeric))
    end

    it 'If the block is not given, my_none? will return true only if none of the collection members is true.' do
      expect(mixing_values.my_none?).to eql(mixing_values.none?)
    end

    it 'If the block is  given for a regular expression, it returns TRUE if none of the element in the array match with the pattern' do
      strings_array_none = strings_array.none?(regular_expression)
      expect(strings_array.my_none?(regular_expression)).to eql(strings_array_none)
    end

    it 'If the block is not given for an empty array, it returns TRUE' do
      expect(empty_array.my_none?).to eql(empty_array.none?)
    end
  end

  describe '#my_count' do
    it 'if it is used in an array without any arguments it returns the number of items in the collection' do
      expect(array_numbers.my_count).to eql(array_numbers.count)
    end

    it 'If it is used in an array with an argument, it returns the number of times the argument repeats in the collection' do
      expect(array_numbers.my_count(Numeric)).to eql(array_numbers.count(Numeric))
    end

    it 'If the block is given it returns the number of times the conditio is true' do
      expect(array_numbers.my_count { |x| x.even? }).to eql(array_numbers.count { |num| num.even? })
    end

    it 'if it is used in an HASH without any arguments it returns the number of items in the collection' do
      expect(hash_numbers.my_count).to eql(hash_numbers.count)
    end
  end

  describe '#my_map' do
    it 'it returns a new array with the result of running block for each element.' do
      expect(array_numbers.my_map { |num| num * num }).to eql(array_numbers.map { |num| num * num })
    end

    it 'it returns a new array with the result of running block for each element.' do
      expect(strings_array.my_map { |str| str + ' ' + str }).to eql(strings_array.map { |str| str + ' ' + str })
    end
  end

  describe '#my_inject' do
    it 'It combines all elements of the enum by applying a symbol that names a method or operator.' do
      expect(array_numbers.my_inject(:+)).to eql(array_numbers.inject(:+))
    end

    it 'It combines all elements of the enum by applying a block that names a method or operator. Takes the parameter of the method as a initial value and the first parameter of the block as accumulator.' do
      expect(array_numbers.my_inject(1) { |product, n| product * n }).to eql(array_numbers.inject(1) { |product, n| product * n })
    end

    it 'It combines all elements of the enum by applying a block that names a method or operator. Takes the first parameter of the block as memo variable.' do
      expect(strings_array.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql(strings_array.inject { |memo, word| memo.length > word.length ? memo : word })
    end
  end

  describe '#multiply_els' do
    it 'It combines all elements multiply.' do
      expect(multiply_els(array_numbers)).to eql(array_numbers.inject(1) { |memo, val| memo * val })
    end
  end
end
# rubocop: enable Layout/LineLength, Style/SymbolProc
