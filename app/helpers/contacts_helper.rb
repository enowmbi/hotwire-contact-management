module ContactsHelper
  def preview_image(contact)
    contact.image.present? ? contact.image : "preview.png"
  end
end
