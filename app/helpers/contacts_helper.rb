module ContactsHelper
  def preview_image(contact, variant)
    contact.image.attached? ? contact.image.variant(variant) : "preview.png"
  end
end
