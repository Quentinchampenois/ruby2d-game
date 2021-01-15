# frozen_string_literal: true

require '../ui_component'

describe UiComponent do
  let(:subject) { described_class }
  let(:data) { { title: 'fake data', x: 50, y: 50, width: 200, height: 200 } }

  describe '#new' do
    let(:subject) { described_class.new }

    it 'creates empty array' do
      expect(subject.ui_elements).to match([])
    end
  end

  describe '#register' do
    let(:subject) { described_class.new }
    let(:get_idx) { false }

    it 'store data in ui_elements' do
      subject.register(data, get_idx)
      expect(subject.ui_elements).to match([data])
    end

    it 'does not return last index' do
      expect(subject.register(data, get_idx)).to be_nil
    end

    context 'when get_idx is true' do
      let(:get_idx) { true }

      it 'store data in ui_elements' do
        expect(subject.register(data, get_idx)).to eq(0)
      end
    end

    context 'when element is nil' do
      let(:data) { nil }

      before do
        subject.register(data, get_idx)
      end

      it 'does not store data in ui_elements' do
        expect(subject.ui_elements).to eq([])
      end
    end
  end
end
