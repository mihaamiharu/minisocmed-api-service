class Post
  def initialize(params)
    @username = params[:username],
    @caption = params[:caption],
    @timestamp = params[:timestamp] || Time.now
  end

  def valid?
    true
  end
end