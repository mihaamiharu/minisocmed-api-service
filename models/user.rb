class User
  def initialize(params)
    @username = params[:username]
    @bio = params[:bio]
    @email = params[:email]
  end

  def valid?
    
    true
  end
end