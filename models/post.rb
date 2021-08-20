class Post
  attr_reader :username, :caption, :timestamp
  def initialize(params)
    @username = params[:username],
    @caption = params[:caption],
    @timestamp = params[:timestamp] || Time.now
  end

  def valid?
<<<<<<< HEAD
    return false if @caption.nil?
=======
>>>>>>> c3baee792d9588f5cbb1bfe8c214b61d4f1e19ae
    true
  end
end