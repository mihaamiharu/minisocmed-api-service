require_relative '../db/db_connection'
require_relative '../models/hashtag'

class Post
  attr_reader :user_id, :caption, :attachment, :tag_id
  def initialize(params)
    @username = params[:username],
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
    query = client.query("INSERT INTO post (user_id, caption, attachment, tag_id) VALUES (#{@user_id}, '#{@caption}', '#{@attachment}', '#{@tag_id}')")
    201 if valid?
  end

  def find_post
    client = create_db_client
    find_post = client.query('SELECT * FROM post ORDER BY post_id DESC LIMIT 1')

    body = find_post
  end

  def create_comment
    client = create_db_client
    query = client.query("INSERT INTO post (user_id, content, attachment, tag_id) VALUES 
    (#{@user_id}, '#{@caption}', '#{@attachment}', #{@tag_id})")
    201 if valid?
  end

  def check_hashtag
    @caption.downcase.scan(/#(\w+)/).flatten.uniq
  end
end

