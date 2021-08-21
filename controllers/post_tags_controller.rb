require_relative '../models/post_tags'

class PostTagsController
  def find_post_tags(params)
    array = []
    post_tags = PostTags.new(params)
    post_tags.find_post_contain_hashtag
    post_tags.find_post_contain_hashtag.each do |res|
      array.push(res)
    end

    if array.empty?
      {
        'message' => 'Success',
        'status' => 200,
        'method' => 'POST',
        'data' => []
      } else
      {
        'message' => 'Success',
        'status' => 200,
        'method' => 'POST',
        'data' => array
      }
    end
  end

  def find_trending_hashtag
    array = []
    post_tags = PostTags.list_trending_hashtag
    {
      'message' => 'Success',
      'status' => 200,
      'method' => 'POST',
      'data' => post_tags.each
    }
  end
end