class Document < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
