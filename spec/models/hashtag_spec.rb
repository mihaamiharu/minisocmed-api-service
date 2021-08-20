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

  describe '#find_hashtag' do
    it 'should return choosen hashtag data' do
      hashtag_data = Hashtag.new(
        hashtag_id: 1,
        name: 'semangat',
        created_at: '2021-08-21 10:19:23'
      )
      expected_result = {
        'hashtag_id' => 1,
        'name' => 'semangat',
        'created_at' => '2021-08-21 10:19:23'
      }
      query = "SELECT hashtag_id FROM hashtag WHERE hashtag.`name` LIKE '%#{hashtag_data.name}%'"
      mock = double
      allow(Mysql2::Client).to receive(:new).and_return(mock)
      expect(mock).to receive(:query).with(mock).and_return(expected_result['hashtag_id'])

      hashtag_data.find_hashtag
    end
  end
end