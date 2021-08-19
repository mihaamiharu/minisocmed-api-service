
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
end