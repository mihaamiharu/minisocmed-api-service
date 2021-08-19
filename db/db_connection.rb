require "mysql2"

def create_db_client
    client = Mysql2::Client.new(
        :host => ENV["DB_HOST"],
        :username => ENV["DB_UNAME"],
        :password => ENV["DB_PASSWORD"],
        :database => ENV["DB_NAME"]
    )
    client
end