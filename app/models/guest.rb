class Guest < ActiveRecord::Base
	has_many :appearances
	has_many :episodes, through: :appearances
end
