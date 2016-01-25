#require 'bcrypt'
class User < ActiveRecord::Base
	has_secure_password
	#give me 2 new methods for user object
	has_many :likes
end