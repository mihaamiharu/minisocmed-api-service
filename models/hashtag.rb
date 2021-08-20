class Hashtag 
  def initialize(params)
    @hashtag_id = params[:hashtag_id],
    @name = params[:name]
  end

  def valid?
    return false if @name.nil?
    true
  end

end