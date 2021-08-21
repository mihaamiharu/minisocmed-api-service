require_relative '../models/post'


class PostController
  def create_post(params)
    array = []
    post = Post.new(params)

    if post.posts == 201
      if params.key?('attachment') && params['attachment'].key?('filename')
        file_name = params['attachment']['filename']
        file = params['attachment']['tempfile']
        file_path = "./public/files/#{file_name}"
        attachment = file_name
        File.open(file_path, 'wb') do |f|
          f.write(file.read)
        end
      end
      post.find_post.each do |res|
        array.push(res)
      end
      {
        'message' => 'Success',
        'status' => 201,
        'method' => 'POST',
        'data' => array
      }
    else
      {
        'message' => 'Failed',
        'status' => 401,
        'method' => 'POST'
      }
    end
  end
end