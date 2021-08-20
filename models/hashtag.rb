require_relative '../db/db_connection'

class Hashtag 

  attr_reader :id, :name
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
    find_hashtag = client.query("SELECT hashtag_id FROM hashtag WHERE hashtag.`name` LIKE '%#{name}%")

    body = find_hashtag
  end

end