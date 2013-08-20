class Appearance < ActiveRecord::Base
	belongs_to :guest
	belongs_to :episode
end
