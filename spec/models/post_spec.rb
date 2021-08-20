require_relative '../../models/post'

describe Post do
  describe '.initialize' do
    it 'cannot be nil' do
      current_time = Time.now
      post_data = Post.new(
        username: 'mihaamiharu',
        caption: 'Main game mulu',
        timestamp: current_time
      )
      expect(post_data).not_to be_nil
    end
  end

  describe '#valid?' do
    context 'assigned with valid params' do
      it 'should return true' do
        current_time = Time.now
        post_data = Post.new(
          username: 'mihaamiharu',
          caption: 'Main game mulu',
          timestamp: current_time
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
end