require_relative '../models/user'

class UserController
  def create_new_user(params)
    body = []
    user = User.new(params)
    if user.create_user == 200
    user.find_user.each do |response|
      body << response
    end    
      {
        'message' => 'Success',
        'status' => 200,
        'method' => 'POST',
        'data' => body
      }
    else
      {
        'message' => 'Failed',
        'status' => 400,
        'method' => 'POST'
      }
    end
  end
end