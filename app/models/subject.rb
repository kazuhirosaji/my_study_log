class Subject < ActiveRecord::Base
  has_many :marks, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, length: {maximum: 30}, uniqueness: true
  validates :user_id, presence: true
end
