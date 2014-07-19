module UsersHelper
  # 与えられたユーザーのGravatar (http://gravatar.com/) を返す。
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def have_subject?(user)
    user.subjects.count > 0
  end

  def date_infos(user)
    infos = []
    user.subjects.each do |subject|
      break if subject.name.nil? 
      marks = subject.marks
      marks.each do |mark|
        break if mark.date.nil?
        infos << "#{subject.name} : #{mark.date}"
      end
    end
    infos
  end

end
