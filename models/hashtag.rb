require_relative '../db/db_connection'

class Hashtag 

  attr_reader :hashtag_id, :name
  def initialize(params)
    @hashtag_id = params[:hashtag_id],
    @name = params[:name]
  end

  def valid?
    return false if @name.nil?
    true
  end

  def find_hashtag
    client = create_db_client
    find_hashtag = client.query("SELECT hashtag_id FROM hashtag WHERE hashtag.`name` LIKE '%#{name}%'")

    body = find_hashtag
  end

  def create_hashtag 
    return false unless valid?

    body = []
    client = create_db_client
    query = client.query("INSERT INTO hashtag (name) VALUES ('#{@name[0]}')")
    query_lastid = client.query('SET @id = LAST_INSERT_ID();')
    query_response = client.query('SELECT hashtag_id FROM hashtag WHERE hashtag_id = @id')

    query_response.each do |response|
      return response['hashtag_id']
    end
  end

  def save_hashtag(post_id)
    client = create_db_client

    query = client.query("INSERT INTO post_tags (hashtag_id,post_id) VALUES (#{create_hashtag},#{post_id})")
  end


end