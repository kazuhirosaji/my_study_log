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
#    user.subjects.
    "programing"
  end

end
