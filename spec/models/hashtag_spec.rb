require_relative '../../models/hashtag'

describe Hashtag do
  before :each do
    @hashtag = Hashtag.new(
      hashtag_id: 1,
      name: 'semangat',
      created_at: '2021-08-21 10:19:23'
    )

    @expected_result = {
      'hashtag_id' => 1,
      'name' => 'semangat',
      'created_at' => '2021-08-21 10:19:23'
    }

    @mock = double
    allow(Mysql2::Client).to receive(:new).and_return(@mock)
  end
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

      query = "SELECT hashtag_id FROM hashtag WHERE hashtag.`name` LIKE '%#{@hashtag.name}%'"

      expect(@mock).to receive(:query).with(query).and_return(@expected_result['hashtag_id'])

      @hashtag.find_hashtag
    end
  end
end