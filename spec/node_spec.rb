require_relative '../node'

describe Node do
  let(:node) {described_class.new(key)}
  let(:key) {17}
  let(:smaller_key) {7}
  let(:bigger_key) {27}

  describe '#key' do
    it 'is the value passed to new' do
      expect(node.key).to eq key
    end
  end

  describe '#insert' do
    context 'when a smaller key is passed' do
      it 'makes a new node to the left' do
        node.insert(smaller_key)
        expect(node.left.key).to eq smaller_key
      end
    end

    context 'when the same key is passed' do
      it 'makes a new node to the right' do
        node.insert(key)
        expect(node.right.key).to eq key
      end
    end

    context 'when a bigger key is passed' do
      it 'makes a new node to the right' do
        node.insert(bigger_key)
        expect(node.right.key).to eq bigger_key
      end
    end
    
    context 'when there is already a node to the left' do
      before { node.insert(smaller_key) }
      context 'when a smaller key is passed' do
        it 'inserts the passed key into the left' do
          expect(node.left).to receive(:insert).with smaller_key
          node.insert(smaller_key)
        end
      end
    end

    context 'when there is already a node to the right' do
      before { node.insert(bigger_key) }
      context 'when a bigger key is passed' do
        it 'inserts the passed key into the right' do
          expect(node.right).to receive(:insert).with key
          node.insert(key)
        end
      end
    end
  end

  describe 'each' do
    context 'for a leaf' do
      it "yields it's key" do
        expect{|b| node.each(&b)}.to yield_with_args(key)
      end
    end

    context 'for a node with a left child' do
      before { node.insert(smaller_key) }
      it 'yields the values in order' do
        expect{|b| node.each(&b)}.to yield_successive_args(smaller_key, key)
      end
    end

    context 'after several inserts in order' do
      before do
        (key+1 .. key+10).each do |k|
          node.insert(k)
        end
      end
      it 'yields the values in order' do
        expect{|b| node.each(&b)}.to yield_successive_args(*(key..key+10))
      end
    end

    context 'after several inserts out of order' do
      let(:key) {4}
      before do
        [2,6,1,3,5,7].each do |k|
          node.insert(k)
        end
      end
      it 'yields the values in order' do
        expect{|b| node.each(&b)}.to yield_successive_args(*(1..7))
      end
    end
  end

  describe '#include?' do
    context "when passed the root node's key" do
      it 'is true' do
        expect(node.include?(key)).to be true
      end
    end

    context "when passed a key that has been inserted" do
      let(:another_key) {12}
      before do
        node.insert(smaller_key)
        node.insert(another_key)
      end

      it 'is true' do
        expect(node.include?(another_key)).to be true
      end
    end
    context "when passed a key that has not been inserted" do
      let(:another_key) {12}
      before do
        node.insert(smaller_key)
      end

      it 'is false' do
        expect(node.include?(another_key)).to be false
      end
    end
  end
end
