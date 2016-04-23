require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product attributes must not be empty" do

    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?

  end


  test "product price must be positive" do

    product = Product.new(
        title: "The Name of the Wind",
        description: "A novel by Patrick Rothfuss.",
        image_url: "kvothe.jpg")

    product.price = -1.00 #should not pass as invalid
    assert product.invalid? #assert invalid
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0.00 #should pass as invalid
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1.00 #should pass as valid
    assert product.valid?

  end

  def new_product(img)
    Product.new(
        title: "Foo",
        description: "Blah blah blah.",
        price: 1,
        image_url: img)
  end

  test "image url need to be valid file type" do

    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
        http://a.b.c/x/y/z/fred.gif } #array of words

    bad = %w{ fred.doc fred.gif/more fred.gif.more } #array of words

    ok.each do |name| #parameter for arg that will be received
      assert new_product(name).valid?, "I thought that #{name} should be valid" #sends the word in the list to the method of new_product
      # which then creates a new product with one of the words as the image_url. Assert that it should return valid
    end

    bad.each do |name|

      assert new_product(name).invalid?,

             "I thought that #{name} shouldn’t be valid"

    end

  end

  test "product must have a unique title" do
    product = Product.new(title: products(:lotr).title, #stealing title from test data to assert that it is not unique
                          description: "Blah.",
                          price: 1,
                          image_url: "fred.gif")

    assert product.invalid?

    assert_equal ["has already been taken"], product.errors[:title]
  end
end
