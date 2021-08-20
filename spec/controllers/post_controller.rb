describe PostController do
  
describe 'create post' do
  context 'given valid params' do
      it 'should return response status 201' do
          controller = Post.Controller.new
          attachment = double()

          mock = double
          response = {
              'message' => 'Success',
              'status' => 201,
              'method' => 'POST',
              'data' => [{
                'post_id' => 1,
                'user_id' => 1,
                'caption' => 'Kamu main #gamemulu',
                'created_at' => '2021-08-21 01:51:03',
                'attachment' => 'valorant.jpeg',
                'tag_id' => nil
              }]
          }

          params = {
            'post_id' => 1,
            'user_id' => 1,
            'caption' => 'Kamu main #gamemulu',
            'created_at' => '2021-08-21 01:51:03',
            'attachment' => attachment,
            'tag_id' => nil
          }

          allow(Posts).to receive(:new).with(params).and_return(mock)
          allow(mock).to receive(:find_user).and_return(response['data'])
          allow(mock).to receive(:posts).and_return(201)

          allow(attachment).to receive("[]").with("filename").and_return("valorant.jpg")
          allow(attachment).to receive(:key?).with("filename").and_return(true)
  
          file = double()
          expect(file).to receive(:write)
          allow(file).to receive(:read)
          allow(attachment).to receive("[]").with("tempfile").and_return(file)
          
          allow(File).to receive(:open) { |&block| block.call(file) }
          allow(@post).to receive(:to_hash).and_return({})

          result = controller.create_post(params)
      end 
  end
end
end