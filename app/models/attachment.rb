class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  has_many_attached :attachments
end
