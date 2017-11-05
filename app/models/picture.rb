class Picture < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  belongs_to :topic, :inverse_of => :pictures
  #validates :topic_id, presence: true
end
