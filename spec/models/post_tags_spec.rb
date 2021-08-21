require_relative '../../models/post_tags'

describe PostTags do
  describe '#find_post_contain_hashtag' do
    it 'should return detail post hash' do
      hashtag = PostTags.new(name: 'game')
      detail_post = {
        'post_id' => 1,
        'username' => 'mihaamiharu',
        'caption' => 'main #game mulu',
        'attachment' => nil,
        'tag_id' => nil,
        'timestamp' => '2021-08-21 11:55:03',
        'name' => 'game'
      }
      query = "SELECT post.post_id, user.username, post.caption, post.attachment, post.tag_id, post.created_at, hashtag.`name`
      FROM post
      LEFT JOIN post_tags ON post.post_id = post_tags.post_id
      LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
      LEFT JOIN user ON user.user_id = post.user_id
      WHERE hashtag.`name` LIKE '%#{hashtag.name}%'"

      mock = double
      allow(Mysql2::Client).to receive(:new).and_return(mock)
      expect(mock).to receive(:query).with(query).and_return([detail_post])
      hashtag.find_post_contain_hashtag
    end
  end
end