require_relative '../db/db_connection'

class PostTags
  attr_reader :name

  def initialize(params)
    @name = params[:name]
  end

  def get_post_contain_hashtag
    client = create_db_client
    get_post_contain_hashtag = client.query("SELECT post.post_id, user.username, post.caption, post.attachment, post.tag_id ,post.created_at,hashtag.`name`
            FROM post
            LEFT JOIN post_tags ON post.post_id = post_tags.post_id
            LEFT JOIN hashtag ON hashtag.hashtag_id = post_tags.hashtag_id
            LEFT JOIN user ON user.user_id = post.user_id
            WHERE hashtag.`name` LIKE '%#{@name}%'")

    data = get_post_contain_hashtag
  end

  def self.get_list_trending_hashtag
    client = create_db_client
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
    response = client.query(query)

    data = response
  end
end