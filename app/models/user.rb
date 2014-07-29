class User < ActiveRecord::Base
	has_many :friends
end
