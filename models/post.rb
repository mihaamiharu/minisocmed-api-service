class Post
  attr_reader :username, :caption, :timestamp
  def initialize(params)
    @username = params[:username],
    @caption = params[:caption],
    @timestamp = params[:timestamp] || Time.now
  end

  def valid?
    return false if @caption.nil?
    true
  end
end