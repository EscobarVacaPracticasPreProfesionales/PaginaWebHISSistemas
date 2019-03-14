class Reference < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  mount_uploaders :pictures, PictureUploader
  validates_presence_of :pictures
  serialize :pictures, JSON
end
