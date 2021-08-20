require_relative '../db/db_connection'

class Hashtag
  attr_reader :name, :hashtag_id

  def initialize(params)
    @hashtag_id = params[:hashtag_id]
    @name = params[:name]
  end

  def valid?
    return false if @name.nil?

    true
  end

  def get_hashtag_id
    client = create_db_client
    get_hashtag_id = client.query("SELECT hashtag_id FROM hashtag WHERE hashtag.`name` LIKE '%#{@name}%'")

    data = get_hashtag_id
  end

  def post
    return false unless valid?

    array = []
    client = create_db_client
    insert = client.query("INSERT INTO hashtag (name) VALUES ('#{@name[0]}')")
    last_insert_id = client.query('SET @id = LAST_INSERT_ID();')
    response = client.query('SELECT hashtag_id FROM hashtag WHERE hashtag_id = @id')

    response.each do |res|
      return res['hashtag_id']
    end
  end

  def post_hashtag(post_id)
    client = create_db_client

    insert = client.query("INSERT INTO post_tags (hashtag_id,post_id) VALUES (#{post},#{post_id})")
  end
end