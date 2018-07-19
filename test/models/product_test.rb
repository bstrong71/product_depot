require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
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
  		title: "1 hat",
  		description: "this is a hat",
  		image_url: "aaa.jpg")
  	
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(
  		title: "1 hat",
  		description: "this is a hat",
  		price: 1,
  		image_url: image_url)
  end

  test "image url" do
  	ok = %w{ foo.gif foo.jpg foo.png FOO.JPG FOO.Jpg 
  					http://a.b.c/x/y/z/foo.gif }
  	bad = %w{ foo.doc foo.gif/more foo.gif.more }

  	ok.each do |image_url|
  		assert new_product(image_url).valid?,
  			"#{image_url} shouldn't be invalid" 
  	end 

  	bad.each do |image_url|
  		assert new_product(image_url).invalid?,
  			"#{image_url} shouldn't be valid"
  	end
  end

  test "product is not valid without a unique title" do
  	product = Product.new(
  		title: products(:three).title,
  		description: "yyy",
  		price: 1,
  		image_url: "foo.gif")
  	assert product.invalid?
  	assert_equal ["has already been taken"], 
  		product.errors[:title]
  end
end




