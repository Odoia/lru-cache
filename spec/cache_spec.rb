require './spec/spec_helper'
require './cache'

describe 'Use a LRU cache' do
  let(:max_count) {}
  let(:cache) { Cache.new(max_count: max_count) }
  let(:execute_actions) {}

  before do
    execute_actions
  end

  context 'When cache max count is 3' do
    let(:max_count) { 3 }

    it 'Show the correct size of array' do
      cache.write('a', 1)
      cache.write('b', 2)
      cache.write('c', 3)
      cache.write('d', 4)

      expect(cache.cache.size).to eq 3
      expect(cache.cache.size).to eq cache.max_count
    end

    context 'When add more then 3 caches and read one' do
      it 'Should remove the less viewed cache' do
        cache.write('a', 1)
        cache.write('b', 2)
        cache.read('a')
        cache.write('c', 3)
        cache.write('d', 4)

        expect(cache.cache.size).to eq 3
        expect(cache.cache[0].include?('a')).to eq true
        expect(cache.cache[1].include?('c')).to eq true
        expect(cache.cache[2].include?('d')).to eq true
      end
    end

    context 'When add more then 3 caches and read four' do
      it 'Should remove the less viewed cache' do
        cache.write('a', 1)
        cache.write('b', 2)
        cache.read('a')
        cache.write('c', 3)
        cache.write('d', 4)
        cache.write('e', 5)
        cache.read('e')
        cache.read('e')
        cache.write('f', 6)
        cache.read('f')
        cache.write('g', 7)

        expect(cache.cache.size).to eq 3
        expect(cache.cache[0].include?('e')).to eq true
        expect(cache.cache[1].include?('f')).to eq true
        expect(cache.cache[2].include?('g')).to eq true
      end
    end

    context 'When remove one key' do
      it 'Should be contain one data in array' do
        cache.write('a', 1)
        cache.write('b', 2)
        cache.remove('a')

        expect(cache.cache.size).to eq 1
        expect(cache.cache.first.include?('b')).to eq true
      end
    end

    context 'When read one key' do
      it 'Should be add one more on the count' do
        cache.write('a', 1)
        cache.write('b', 2)
        cache.write('c', 3)
        cache.read('a')

        expect(cache.cache.first[:count]).to eq 1
        expect(cache.cache[1][:count]).to eq 0
        expect(cache.cache[2][:count]).to eq 0
      end
    end
  end
end
