class Product < ApplicationRecord
	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true
	validates :title, length: { maximum: 30, message: 'must be 30 characters or less' }
	validates :description, length: { maximum: 300, message: 'must be 300 characters or less' }
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	validates :price, numericality: { greater_than_or_equal_to: 0.01, message: "can't be less than 0.01" }
end
