require 'sinatra'
require 'json'

require_relative './controllers/user_controller'

before do
  content_type :json
end


post '/create_user' do
  controller = UsersController.new
  response = controller.create_new_user(params)
  status response['status']
  return response.to_json
end
