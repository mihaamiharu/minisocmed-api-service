class User
  def initialize(params)
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio]
  end

  def valid?
    return false if @username.nil? || @email.nil?  || !@email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    true
  end
end