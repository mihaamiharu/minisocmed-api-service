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
end