# frozen_string_literal: true

require '../components/ui_component_text'

describe UiComponentText do
  let(:subject) { described_class.new }
  let(:get_idx) { false }
  let(:data) { { title: 'fake data', x: 50, y: 50, width: 200, height: 200 } }

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
