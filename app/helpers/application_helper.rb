#The helper methods are just available in the views , NOT in the controllers, to add a method with access from controllers created in application_controller
module ApplicationHelper
  def gravatar_for(user,options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url,alt: user.username,class: "rounded shadow mx-auto d-block mt-4")
  end
end
