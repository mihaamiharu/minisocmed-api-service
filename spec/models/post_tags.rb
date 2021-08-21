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
      it 'does return response by hashtag name' do
        hashtag = PostTags.new(name: 'gamemulu')
        query = "SELECT post.post_id, user.username, post.caption, post.attachment, post.tag_id, post.created_at, hashtag.`name`
        FROM post
        LEFT JOIN post_tags ON post.post_id = post_tags.post_id
        LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
        LEFT JOIN user ON user.user_id = post.user_id
        WHERE hashtag.`name` LIKE '%#{hashtag.name}%'"
  
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
  
        hashtag.find_post_with_hashtag
      end
    end
  end

  describe '#find_top_trending' do
    context 'when trending is found' do
      it 'does return response for trending hashtag' do
        hashtag = PostTags.new(

        )
        hashtag.find_top_trending
      end
    end
  end
end