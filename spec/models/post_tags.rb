require_relative '../../models/post_tags'

describe PostTags do
  describe '.initialize' do
    it 'cannot be nil' do
      post_tag = PostTags.new(
        name: 'gamemulu'
      )
      expect(post_tag).not_to be_nil
    end
  end
end


