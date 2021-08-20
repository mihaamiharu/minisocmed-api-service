require_relative '../db/db_connection'
require_relative '../models/hashtag'

class Post
  attr_reader :user_id, :caption, :attachment, :tag_id
  def initialize(params)
    @user_id = params[:user_id],
    @caption = params[:caption],
    @attachment = params[:attachment],
    @tag_id = params[:tag_id]
  end

  def valid?
    return false if @caption.nil? || @caption.length > 1000
    true
  end

  def posts
    return false unless valid?
    client = create_db_client
    client.query("INSERT INTO post (user_id, caption, attachment, tag_id) VALUES (#{@user_id}, '#{@caption}', '#{@attachment}', #{@tag_id})")
    hashtag = check_hashtag
    hashtag.each do |data|
      hash = Hashtag.new(name: data)
      hash.save_hashtag(client.last_id)
    end
    return 201 if valid?
  end

  def find_post
    client = create_db_client
    find_post = client.query('SELECT * FROM post ORDER BY post_id DESC LIMIT 0,1')

    data = find_post
  end

  def check_hashtag
    @caption.downcase.scan(/#(\w+)/).flatten.uniq
  end
end

