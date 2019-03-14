class Article < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON
  validates_presence_of :pictures
  
end
