class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 5 }
    has_many :article_categories
    has_many :categories, through: :article_categories, dependent: :destroy
    has_one_attached :image, dependent: :destroy
    has_many :pictures, as: :imageable
    accepts_nested_attributes_for :pictures
    has_many :attachments, as: :attachable
    accepts_nested_attributes_for :pictures
    enum status: [:draft, :pending, :archieved, :rejected]
end
