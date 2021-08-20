require_relative '../../models/post'

describe Post do
  before :each do
    @post_data = Post.new(
      post_id: 1,
      username: 'mihaamiharu',
      caption: 'Main game mulu',
      timestamp: '2021-08-17 07:00:13',
      attachment: nil
    )

    @expected_result = {
        'post_id' => 1,
        'username' => 'mihaamiharu',
        'caption' => 'Main game mulu',
        'timestamp' => '2021-08-17 07:00:13',
        'attachment' => nil
    }
  end
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
        mock = double
        query = "INSERT INTO post (username, caption) VALUES ('#{@post_data.username}', '#{@post_data.caption}')"
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query).and_return(201)

        @post_data.posts
      end
    end
  end

  context '#find_post' do
    it 'should return new post' do
      query = 'SELECT * FROM post ORDER BY post_id DESC LIMIT 1'
      mock = double
      allow(Mysql2::Client).to receive(:new).and_return(mock)
      expect(mock).to receive(:query).with(query).and_return([@expected_result])

      @post_data.find_post
    end
  end

  
end