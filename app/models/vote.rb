class Vote < ApplicationRecord
  belongs_to :user
  has_one :work
  validates :user_id, presence: true
  validates :work_id, presence: true
  validates_associated :user
  validates_associated :work
  validates_with UniqueUserVote
end
