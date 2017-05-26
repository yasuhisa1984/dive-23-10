module ApplicationHelper
  def profile_img(user)
    if user.avatar?
      return image_tag(user.avatar, alt: user.name, :size => "164x164")
    else
      img_url = 'no_image.png'
      image_tag(img_url, alt: user.name, :size => "164x164")
    end
  end
end
