require_relative '../../models/post'

describe Post do
  before :each do
    @post_data = Post.new(
      post_id: 1,
      user_id: 1,
      caption: 'Main #game mulu',
      attachment: nil,
      tag_id: 1,
      created_at: '2021-08-17 07:00:13'
    )

    @expected_result = {
        'post_id' => 1,
        'user_id' => 1,
        'caption' => 'Main #game mulu',
        'attachment' => nil,
        'tag_id' => 1,
        'created_at' => '2021-08-17 07:00:13'
    }
  end
  describe '.initialize' do
    it 'cannot be nil' do
      post_data = Post.new(
        user_id: 1,
        caption: 'Main game mulu'
      )
      expect(post_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assigned with valid params' do
      it 'should return true' do
        post_data = Post.new(
          user_id: 1,
          caption: 'Main game mulu'
        )
        expect(post_data.valid?).to eq(true)
      end
    end

    context 'when caption is empty' do
      it 'should return false' do
        post_data = Post.new(
          user_id: 1,
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
        query = "INSERT INTO post (user_id, caption, attachment, tag_id) VALUES (#{@post_data.user_id}, '#{@post_data.caption}', '#{@post_data.attachment}', '#{@post_data.tag_id}')"
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

  describe '#create_comment' do
    context 'given valid params' do
      it 'should write comment on a post' do
        query = "INSERT INTO post (user_id, content, attachment, tag_id) VALUES 
        (#{@post_data.user_id}, '#{@post_data.caption}', '#{@post_data.attachment}', '#{@post_data.tag_id})"
        mock = double
        allow(mock).to receive(:last_id).and_return(1)
        expect(mock).to receive(:query).with(mock).and_return(200)

        mock_hashtag = double
        allow(Hashtag).to receive(:new).and_return(mock_hashtag)
        allow(mock_hashtag).to receive(:create_hashtag)
        allow(mock_hashtag).to receive(:save_hashtag)
        @post_data.create_comment
      end
    end
  end

  describe '#check_hashtag' do
    context 'when created post or comment have hashtag' do
      it 'should return contained hashtag' do
        result = %w[game]

        expect(@post_data.check_hashtag).to eq(result)
      end
    end
  end
end