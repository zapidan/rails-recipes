require 'test_helper'

class ReviewTest < ActiveSupport::TestCase 
  def setup
    @chef = Chef.create(chefname: "John", email: 'john.doe@example.com', password: 'password')
    @reviewer = Chef.create(chefname: "test", email: 'test@test.com', password: 'password')
    @recipe = @chef.recipes.create(name: "chicken", summary: "this is a great recipe", description: "just do this recipe. It's not that hard")
    @review = @recipe.reviews.build(body: "this is an excellent recipe!")
    @review.chef = @reviewer
  end

  test "review should be valid" do
    assert @review.valid?
  end

  test "review body should be present" do
    @review.body = " "
    assert_not @review.valid?
  end

  test "review body length should not be too long" do
    @review.body = "a" * 501
    assert_not @review.valid?
  end

  test "review body length should not be too short" do
    @review.body = "a" * 4
    assert_not @review.valid?
  end
end