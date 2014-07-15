module SubjectsHelper
  def get_subject_id(user, subject_name)
    user.subjects.find_by(name: subject_name).id
  end
end
