class Topic < ActiveRecord::Base
  validates :title,  presence: true
  belongs_to :user
end
