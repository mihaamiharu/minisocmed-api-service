require_relative '../db/db_connection'

class PostTags
  attr_reader :name

  def initialize(params)
    @name = params[:name]
  end

end