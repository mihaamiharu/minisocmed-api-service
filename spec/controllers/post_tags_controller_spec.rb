require_relative '../../controllers/post_tags_controller'

describe PostTagsController do
  describe 'search post hashtag' do
    it 'should return post that have hashtag' do
      hashtag = {
        'name' => 'game'
      }

      expected_response = {
        'message' => 'Success',
        'status' => 200,
        'method' => 'POST',
        'data' => [{
          'post_id' => 1,
          'username' => 'mihaamiharu',
          'caption' => 'Main #game mulu',
          'attachment' => nil,
          'tag_id' => nil,
          'created_at' => '2021-08-21 07:00:13'
        }]
      }

      mock = double
      allow(mock).to receive(:find_post_contain_hashtag).and_return(expected_response['data'])
      allow(PostTags).to receive(:new).and_return(mock)

      controller = PostTagsController.new
      result = controller.find_post_tags(expected_response)
      expect(result).to eq(expected_response)
    end
  end

  describe 'when post dont have tags' do
    it 'should response with a 404' do
      params = {
        'name' => 'Au ah gelap'
      }

      expected_response = {
        'message' => 'Success',
        'status' => 200,
        'method' => 'POST',
        'data' => []
      }

      mock = double
      allow(mock).to receive(:find_post_contain_hashtag).and_return([])
      allow(PostTags).to receive(:new).and_return(mock)

      controller = PostTagsController.new
      result = controller.find_post_tags(params)
      expect(result).to eq(expected_response)
    end
  end
end