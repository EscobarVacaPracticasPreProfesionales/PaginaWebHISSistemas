class Service < ApplicationRecord
  belongs_to :user
  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON
end
