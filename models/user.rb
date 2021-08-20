require_relative '../db/db_connection'
class User
  attr_reader :username, :email, :bio
  def initialize(params)
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio]
  end

  def valid?
    return false if @username.nil? || @email.nil?  || !@email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    true
  end

  def create_user
    client = create_db_client
    query = client.query("INSERT INTO user (username, email, bio) VALUES ('#{@username}','#{@email}','#{@bio}')")
    query_last = client.query('SET @id = LAST_INSERT_ID();')
    query_response = client.query('SELECT * FROM users WHERE user_id = @id')
    return 200 if valid?
  end

  def find_user
    client = create_db_client
    find_user = client.query("SELECT * FROM user ORDER BY user_id DESC LIMIT BY 1")

    body = find_user
  end


end