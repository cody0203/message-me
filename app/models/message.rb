class Message < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 500 }
end
