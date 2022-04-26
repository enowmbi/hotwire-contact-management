module ContactsHelper
  def preview_image(contact)
    contact.image.attached? ? contact.image : "preview.png"
  end
end
