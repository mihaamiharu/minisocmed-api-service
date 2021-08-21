require 'sinatra'
require 'json'

require_relative './controllers/user_controller'
require_relative './controllers/post_controller'
require_relative './controllers/post_tags_controller'

before do
  content_type :json
end

get '/api/' do
  response = 'Hello!'
  return response.to_json
end

post '/api/user/register' do
  controller = UsersController.new
  response = controller.create_new_user(params)
  status response['status']
  return response.to_json
end

post '/api/hashtag/details' do
  controller = PostTagsController.new
  response = controller.find_post_tags(params)
  status response['status']
  return response.to_json
end

get '/api/hashtag/trending' do
  controller = PostTagsController.new
  response = controller.find_trending_hashtag
  status response['status']
  return response.to_json
end

post '/api/post/create' do
  controller = PostController.new
  response = controller.create_post(params)
  status response['status']
  return response.to_json
end
