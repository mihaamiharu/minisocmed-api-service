require_relative '../../models/hashtag'

describe Hashtag do
  describe '.initialize' do
    it 'cannot be nil' do
      hashtag_data = Hashtag.new(
        hashtag_id: 1,
        name: 'semangat'
      )
      expect(hashtag_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assign with valid params' do
      it 'should return true' do
        hashtag_data = Hashtag.new(
          hashtag_id: 1,
          name: 'semangat'
        )
        expect(hashtag_data.valid?).to eq(true)
      end
    end
  end
end