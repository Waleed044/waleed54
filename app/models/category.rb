class Category < ApplicationRecord
    has_many :article_categories
    has_many :articles, through: :article_categories
    # has_one :picture, as: :imageable
    has_many :pictures, as: :imageable
    accepts_nested_attributes_for :pictures
    has_many :attachments, as: :attachable
    accepts_nested_attributes_for :attachments
end