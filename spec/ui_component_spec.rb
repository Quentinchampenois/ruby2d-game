# frozen_string_literal: true

require '../ui_component'

describe UiComponent do
  let(:subject) { described_class.new }
  let(:get_idx) { false }
  let(:data) { { title: 'fake data', x: 50, y: 50, width: 200, height: 200 } }

  UiComponent.class_eval do
    def search(key, value)
      @ui_elements.select do |obj|
        obj[key] == value
      end
    end
  end

  describe '#new' do
    it 'creates empty array' do
      expect(subject.ui_elements).to match([])
    end
  end

  describe '#register' do
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

    context 'with list of elements' do
      before do
        ['Start game', 'Resume game', 'Stop game', 'Hello player !'].each do |text|
          subject.register({ title: text, x: 50, y: 50, width: 200, height: 200 }, get_idx)
        end
      end

      it 'registers all elements' do
        expect(subject.ui_elements.count).to eq(4)
      end
    end
  end

  describe '#pick' do
    before do
      ['Start game', 'Resume game', 'Stop game', 'Hello player !'].each do |text|
        subject.register({ title: text, x: 50, y: 50, width: 200, height: 200 }, get_idx)
      end
    end

    it 'picks a unique element' do
      expect(subject.pick(:title, 'Resume game')).to eq(title: 'Resume game', x: 50, y: 50, width: 200, height: 200)
    end
  end

  describe '#pick_all' do
    before do
      ['Resume game', 'Resume game', 'Stop game', 'Hello player !'].each do |text|
        subject.register({ title: text, x: 50, y: 50, width: 200, height: 200 }, get_idx)
      end
    end

    it 'picks multiple elements' do
      expect(subject.pick_all(:title, 'Resume game')).to eq([
                                                              { title: 'Resume game', x: 50, y: 50, width: 200,
                                                                height: 200 },
                                                              { title: 'Resume game', x: 50, y: 50, width: 200,
                                                                height: 200 }
                                                            ])
    end
  end
end
