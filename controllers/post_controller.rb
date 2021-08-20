require_relative '../models/post'

class PostController
  def create_post(params)
    array = Array.new
    posts = Post.new(params)

    if posts.post == 201
        if params.key?("attachment") && params["attachment"].key?("filename")
            file_name = params["attachment"]["filename"]
            file = params["attachment"]["tempfile"]
            file_path = "./public/files/#{file_name}" 
            attachment = file_name
            File.open(file_path, 'wb') do |f|
              f.write(file.read)
            end
        end
        posts.get_new_insert.each do |res|
            array.push(res)
        end
        return {
            'message' => 'Success',
            'status' => 201,
            'method' => 'POST',
            'data' => array
        }
    else
        return {
            'message' => 'Failed',
            'status' => 401,
            'method' => 'POST',
        }
    end
  end
end
