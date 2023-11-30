class User < ApplicationRecord
	self.table_name = 'users'

	validates :name, presence: true
	validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit contact number" }

	after_create :generate_uniq_token

	private

	def generate_uniq_token
  	self.description = SecureRandom.alphanumeric
  	save
	end
end
