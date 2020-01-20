class Pin < ApplicationRecord
  validates :title, :description, presence: true
end
