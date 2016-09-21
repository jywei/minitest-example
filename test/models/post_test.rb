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

  def test_post_valid
    assert @post.valid?
  end

  def test_title_present
    @post.title = "     "
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 51
    assert_not @post.valid?
  end

  def test_post_uniqueness
    duplicate_post = @post.dup
    duplicate_post.content = @post.content.upcase
    @post.save
    assert_not duplicate_post.valid?
  end

  def test_lowercase_title
    mixed_case_title = "FooExAMPle.BaR"
    @post.title = mixed_case_title
    @post.save
    assert_equal mixed_case_title.downcase, @post.reload.title
  end
end
