require_relative '../../models/post_tags'

describe PostTags do
  before :each do
    @stub_client = double()
    @post_hashtags = PostTags.new(name: 'gamemulu')
    @response = {
      'post_id' => 1,
      'username' => 'mihaamiharu',
      'caption' => 'kamu main #gamemulu',
      'attachment' => nil,
      'tag_id' => nil,
      'created_at' => '2021-08-15 00:51:03',
      'name' => 'gamemulu'
    }
    allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
  end

  describe 'get post contain hashtag' do
    it 'should return response by hashtag name post' do
      stub_query = "SELECT post.post_id, user.username, post.caption, post.attachment, post.tag_id ,post.created_at,hashtag.`name`
            FROM post
            LEFT JOIN post_tags ON post.post_id = post_tags.post_id
            LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
            LEFT JOIN user ON user.user_id = post.user_id
            WHERE hashtag.`name` LIKE '%#{@post_hashtags.name}%'"

      expect(@stub_client).to receive(:query).with(stub_query).and_return([@response])

      @post_hashtags.get_post_contain_hashtag
    end
  end

  describe 'get list trending hashtag' do
    it 'should return response by hashtag name with count' do
      response = {
        'hashtag_id' => 1,
        'count' => 10,
        'name' => 'gamemulu'
      }

      query = 
            "
            SELECT
                hashtag.hashtag_id,
                COUNT(hashtag.hashtag_id) AS count,
                hashtag. `name`
            FROM
                post
                LEFT JOIN post_tags ON post.post_id = post_tags.post_id
                LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
                LEFT JOIN user ON user.user_id = post.user_id
            WHERE
                post.created_at > DATE_SUB(NOW(), INTERVAL 24 HOUR)
            GROUP BY
                hashtag.`name`
            ORDER BY
                count DESC
            LIMIT 5
            "

      expect(@stub_client).to receive(:query).with(query).and_return([response])

      post_hashtag = PostTags.get_list_trending_hashtag
    end
  end
end
