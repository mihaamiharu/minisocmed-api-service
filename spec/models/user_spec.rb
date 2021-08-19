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
  end
end