require_relative '../../models/post_tags'

describe PostTags do
  describe '.initialize' do
    it 'cannot be nil' do
      post_tag = PostTags.new(
        name: 'gamemulu'
      )
      expect(post_tag).not_to be_nil
    end
  end

  describe '#find_post_with_hashtag' do
    context 'when post is found' do
      it 'should return response by hashtag name' do
        hashtags = PostTags.new(name: 'gamemulu')
        query = "SELECT post.post_id, user.username, post.caption, post.attachment, post.tag_id, post.created_at, hashtag.`name`
        FROM post
        LEFT JOIN post_tags ON post.post_id = post_tags.post_id
        LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
        LEFT JOIN user ON user.user_id = post.user_id
        WHERE hashtag.`name` LIKE '%#{hashtags.name}%'"
  
        expected_result = {
          'post_id' => 1,
          'username' => 'mihaamiharu',
          'caption' => 'kenapa kamu main #gamemulu',
          'attachment' => nil,
          'tag_id' => nil,
          'created_at' => '2021-08-21 00:19:30',
          'name' => 'gamemulu'
        }
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query).and_return([expected_result])
  
        hashtags.find_post_with_hashtag
      end
    end
  end
end


