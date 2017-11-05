class Topic < ActiveRecord::Base
  validates :title,  presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy, :inverse_of => :topic
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: :all_blank
end
