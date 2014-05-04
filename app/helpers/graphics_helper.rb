module GraphicsHelper

  def gravatar_for email
    id = Digest::MD5::hexdigest(email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}"
    image_tag(url, alt: "avatar", class: "comment_image")
  end

end
