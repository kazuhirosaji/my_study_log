class Subject < ActiveRecord::Base
  has_many :marks, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, length: {maximum: 30}
  validates :name, :uniqueness => {:scope => :user_id }
  validates :user_id, presence: true
end
