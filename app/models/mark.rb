class Mark < ActiveRecord::Base
  belongs_to :subject
  VALID_DATE_REGEX = /\A[a-z]+ [a-z]+ \d{2} \d{4} \d{2}:\d{2}:\d{2}.*\z/i  
  validates :date, presence: true, format: { with: VALID_DATE_REGEX }
  validates :subject_id, presence: true
end
