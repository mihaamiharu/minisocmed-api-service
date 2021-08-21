require_relative '../../controllers/post_controller'

describe PostController do
  before :each do
    @controller = PostController.new
  end
  describe 'create_post' do
    context 'when assign by valid params' do
      it' should return a 201' do
        expected_response = {
          'message' => 'Success',
          'status' => 201,
          'method' => 'POST',
          'data' => [{
            'post_id' => 1,
            'user_id' => 1,
            'caption' => 'Main #game mulu',
            'attachment' => 'image.jpeg',
            'tag_id' => nil,
            'created_at' => '2021-08-17 07:00:13'
          }]
        }

        mock_attachment = double
        post_data = {
            'post_id' => 1,
            'user_id' => 1,
            'caption' => 'Main #game mulu',
            'attachment' => mock_attachment,
            'tag_id' => nil,
            'created_at' => '2021-08-17 07:00:13'
        }

        
        mock = double
        allow(Post).to receive(:new).with(post_data).and_return(mock)
        allow(mock).to receive(:find_post).and_return(expected_response['data'])
        allow(mock).to receive(:posts).and_return(201)

        allow(mock_attachment).to receive('[]').with('filename').and_return('image.jpeg')
        allow(mock_attachment).to receive(:key?).with('filename').and_return(true)

        mock_file = double
        expect(mock_file).to receive(:write)
        expect(mock_file).to receive(:read)
        allow(mock_attachment).to receive('[]').with('tempfile').and_return(mock_file)

        allow(@File).to receive(:open) { |&block| block.call(file) }
        allow(@posts).to receive(:to_hash).and_return({})

        result = @controller.create_post(post_data)
      end
    end

    context 'when assigned by invalid params' do
      it 'should return a 401' do
        expected_response = {
          'message' => 'Failed',
          'status' => 401,
          'method' => 'POST',
        }

        post_data = {
          'user_id' => 1,
          'caption' => nil
        }
        mock = double
        allow(Post).to receive(:new).with(post_data).and_return(mock)
        allow(mock).to receive(:find_post).and_return([])
        allow(mock).to receive(:posts).and_return(false)

        result = @controller.create_post(post_data)
        expect(result).to eq(expected_response)
      end
    end
  end
end