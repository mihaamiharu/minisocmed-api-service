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
end