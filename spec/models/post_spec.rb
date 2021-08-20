require_relative '../../models/post'

describe Post do
  describe '.initialize' do
    it 'cannot be nil' do
      post_data = Post.new(
        username: 'mihaamiharu',
        caption: 'Main game mulu'
      )
      expect(post_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assigned with valid params' do
      it 'should return true' do
        post_data = Post.new(
          username: 'mihaamiharu',
          caption: 'Main game mulu'
        )
        expect(post_data.valid?).to eq(true)
      end
    end

    context 'when caption is empty' do
      it 'should return false' do
        post_data = Post.new(
          username: 'mihaamiharu',
          caption: nil,
        )
        expect(post_data.valid?).to eq(false)
      end
    end
  end

  describe '#post' do
    describe 'when assigned with valid params' do
      it 'should create new post' do
        post_data = Post.new(
          post_id: 1,
          username: 'mihaamiharu',
          caption: 'Main game mulu',
          attachment: nil,
          timestamp: Time.now
        )

        mock = double
        query = "INSERT INTO post (username, caption) VALUES ('#{post_data.username}', '#{post_data.caption}')"
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query).and_return(201)

        post_data.posts
      end
    end
  end
end