# Tests.rb
require_relative '../enumerable.rb'

RSpec.describe Enumerable do
  array_numbers = [1, 5, 9, 8, 7, 3, 4]
  hash_numbers = { 'a' => 3, 'b' => 7, 'c' => 9, 'd' => 8, 'e' => 6, 'f' => 2 }

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
end
