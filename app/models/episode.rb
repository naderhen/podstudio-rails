class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_many :appearances
  has_many :guests, through: :appearances
end
