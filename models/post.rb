require_relative '../db/db_connection'

class Post
  attr_reader :username, :caption
  def initialize(params)
    @username = params[:username],
    @caption = params[:caption]
  end

  def valid?
    return false if @caption.nil? || @caption.length > 1000
    true
  end

  def posts
    return false unless valid?
    client = create_db_client
    query = client.query("INSERT INTO post (username, caption) VALUES ('#{@username}', '#{@caption}')")
    201 if valid?
  end

  def find_post
    client = create_db_client
    find_post = client.query('SELECT * FROM post ORDER BY post_id DESC LIMIT 1')

    body = find_post
  end

  
end

