require_relative '../../controllers/user_controller'

describe UserController do
  describe 'create_new_user' do
    context 'when assign with valid params' do
      it 'returns a 200' do
        expected_response = {
          'message' => 'Success',
          'status' => 200,
          'method' => 'POST',
          'data' => [{
            'user_id' => 1,
            'username' => 'mihaamiharu',
            'email' => 'mihaamiharu.com',
            'bio' => 'au ah gelap',
            'created_at' => '2021-08-21 01:17:03',
          }]
        }

        mock =double
        allow(User).to receive(:new).and_return(mock)
        expect(mock).to receive(:find_user).and_return(expected_response['data'])
        expect(mock).to receive(:create_user).and_return(200)

        hash_user = {
          'user_id' => 1,
          'username' => 'mihaamiharu',
          'email' => 'mihaamiharu.com',
          'bio' => 'au ah gelap',
          'created_at' => '2021-08-21 01:17:03',
        }

        controller = UserController.new
        result = controller.create_new_user(hash_user)
        expect(result).to eq(expected_response)
      end
    end

    context 'when assign with invalid params' do
      it 'returns a 400' do
        mock = double
        allow(User).to receive(:new).and_return(mock)
        
        expect(mock).to receive(:create_user)

        expected_response = {
          'message' => 'Failed',
          'status' => 400,
          'method' => 'POST'
        }

        params = {
          'username' => nil,
          'bio' => nil,
          'email' => 'mihaa.com'
        }

        controller = UserController.new
        result = controller.create_new_user(params)
        expect(result).to eq(expected_response)
      end
    end
  end
end