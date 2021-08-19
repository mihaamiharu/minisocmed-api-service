require_relative '../../models/user'
describe User do
  describe '.initialize' do
    it 'cannot be nil' do
      user = User.new(
        username: 'mihaamiharu',
        email: 'mihaa@miharu.com',
        bio: 'au ah gelap'
      )
      expect(user).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assign with valid params' do
      it 'should return true' do
        user = User.new(
          username: 'mihaamiharu',
          email: 'mihaa@miharu.com',
          bio: 'au ah gelap'
        )

        expect(user.valid?).to eq(true)
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
end