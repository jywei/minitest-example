require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @post = create(:post)
    @comment = create(:comment, post_id: @post.id)
  end

  def test_relation
    # comment = @post.comments.create
    assert_equal @comment, @post.comments.first
  end
end
