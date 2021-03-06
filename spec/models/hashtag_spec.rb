require_relative '../../models/hashtag'

describe Hashtag do
  before :each do
    @hashtag = Hashtag.new(
      hashtag_id: 1,
      name: 'game',
      created_at: '2021-08-21 10:19:23'
    )

    @expected_result = {
      'hashtag_id' => 1,
      'name' => 'game',
      'created_at' => '2021-08-21 10:19:23'
    }

    @mock = double
    allow(Mysql2::Client).to receive(:new).and_return(@mock)
  end

  describe '.initialize' do
    it 'cannot be nil' do
      hashtag_data = Hashtag.new(
        hashtag_id: 1,
        name: 'game'
      )
      expect(hashtag_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assign with valid params' do
      it 'should return true' do
        expect(@hashtag.valid?).to eq(true)
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

  describe 'create_hashtag' do
    context 'when assign with valid params' do
      it 'should create hashtag' do
        query = "INSERT INTO hashtag (name) VALUES ('#{@hashtag.name[0]}')"
        query_lastid = "SET @id = LAST_INSERT_ID();"
        query_response = "SELECT hashtag_id FROM hashtag WHERE hashtag_id = @id"

        expect(@mock).to receive(:query).with(query)
        expect(@mock).to receive(:query).with(query_lastid)
        expect(@mock).to receive(:query).with(query_response).and_return([{}])

        @hashtag.create_hashtag
      end
    end
  end

  describe '#save_hashtag' do
    context 'when assign with valid params' do
      it 'does save post tags' do
      hashtag_id = 1
      query = "INSERT INTO hashtag (name) VALUES ('#{@hashtag.name[0]}')"
      query_lastid = "SET @id = LAST_INSERT_ID();"
      query_selectid = "SELECT hashtag_id FROM hashtag WHERE hashtag_id = @id"
      query_response = "INSERT INTO post_tags (hashtag_id,post_id) VALUES (#{hashtag_id},1)"

      expected_result = [{
        'hashtag_id' => 1
      }]

      

      expect(@mock).to receive(:query).with(query)
      expect(@mock).to receive(:query).with(query_lastid)
      expect(@mock).to receive(:query).with(query_selectid).and_return(expected_result)
      expect(@mock).to receive(:query).with(query_response)

      @hashtag.save_hashtag(1)
      end
    end
  end
end