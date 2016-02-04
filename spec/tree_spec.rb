require_relative '../tree'

describe Tree do
  let(:tree) {described_class.new}

  describe '#insert' do
    context 'with no root' do
      it 'creates a root node' do
        tree.insert(7)
        expect(tree.root.key).to eq 7
      end
    end

    context 'with a root' do
      before { tree.insert(10) }
      it 'delagates to the root node' do
        expect(tree.root).to receive(:insert).with 7
        tree.insert(7)
      end
    end
  end

  describe '#each' do
    context 'with no root' do
      it "doesn't yield" do
        expect{|b| tree.each(&b)}.not_to yield_control
      end
    end

    context 'with a root' do
      before { tree.insert(10) }
      it 'yields the root key' do
        expect{|b| tree.each(&b)}.to yield_successive_args(10)
      end
    end

    context 'after several insertions' do
      before do
        10.downto(1) {|i| tree.insert(i)}
      end
      it 'yields the inserted elements in order' do
        expect{|b| tree.each(&b)}.to yield_successive_args(*(1..10))
      end
    end
  end

  describe '#include?' do
  end
end
