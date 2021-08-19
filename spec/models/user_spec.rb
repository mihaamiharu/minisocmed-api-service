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
        query = "INSERT INTO user (username, email, bio) VALUES ('#{user.username}','#{user.email}','#{user.bio}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)

        user.create_user
      end
    end
  end
end