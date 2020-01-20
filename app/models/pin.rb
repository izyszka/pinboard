class Pin < ApplicationRecord
  validates :title, :description, :picture, presence: true

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  acts_as_votable
end
