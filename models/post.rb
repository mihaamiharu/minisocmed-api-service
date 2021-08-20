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
end

