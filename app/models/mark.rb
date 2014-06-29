class Mark < ActiveRecord::Base
  belongs_to :subject
  validates :date, presence: true
  validates :subject_id, presence: true
end
