require_relative '../../models/user'
describe User do
  before :each do
    @user_data = User.new(
      username: 'mihaamiharu',
      email: 'mihaa@miharu.com',
      bio: 'au ah gelap'
    )
  end
  describe '.initialize' do
    it 'cannot be nil' do
      expect(@user_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assign with valid params' do
      it 'should return true' do
        expect(@user_data.valid?).to eq(true)
      end
    end

    context 'assign with invalid params' do
      it 'should return false without username params' do
        user = User.new(
          email: 'mihaa@miharu.com',
          bio: 'au ah gelap')
        expect(user.valid?).to eq(false)
      end

      it 'should return false without email params' do
        user = User.new(
          username: 'mihaamiharu',
          bio: 'au ah gelap')
        expect(user.valid?).to eq(false)
      end

      it 'should return false when email format is wrong' do
        user = User.new(
          username: 'mihaamiharu',
          email: 'mihaamiharu.com',
          bio: 'au ah gelap'
        )
        expect(user.valid?).to eq(false)
      end
    end
  end

  describe '#create_user' do
    context 'assign with valid params' do
      it 'should save user data' do
        user = User.new(
          username: 'mihaamiharu',
          email: 'mihaamiharu.com',
          bio: 'au ah gelap'
        )

        expected_result = {
          'user_id' => 1,
          'username' => 'mihaamiharu',
          'email' => 'mihaa@miharu.com',
          'bio' => 'Main game mulu'
        }

        query = "INSERT INTO user (username, email, bio) VALUES ('#{user.username}','#{user.email}','#{user.bio}')"
        query_last = "SET @id = LAST_INSERT_ID();"
        query_response = "SELECT * FROM users WHERE user_id = @id"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:query).with(query_last)
        expect(mock).to receive(:query).with(query_response).and_return([expected_result])

        user.create_user
      end
    end
  end

  describe 'find_user' do
    it 'should return a new data user' do
      query = "SELECT * FROM user ORDER BY user_id DESC LIMIT BY 1"
      expected_result = {
        'user_id' => 1,
        'username' => 'mihaamiharu',
        'email' => 'mihaa@miharu.com',
        'bio' => 'Main game mulu'
      }

      mock = double
      allow(Mysql2::Client).to receive(:new).and_return(mock)
      expect(mock).to receive(:query).with(query).and_return([expected_result])
      @user_data.find_user
    end
  end
end