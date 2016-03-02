class Shop < ActiveRecord::Base
	belongs_to :user
	has_many :products

	mount_uploader :profile_image, UserProfileUploader
	mount_uploader :header_image, UserHeaderImageUploader
	has_many :products, :dependent => :delete_all

	validate :picture_size


	private

	def picture_size
		if profile_image.size > 5.megabytes || header_image.size > 5.megabytes
			errors.add("Image should be less than 5MB")
		end
	end
end
