class AddressDecorator < Draper::Base
  decorates :address
  def street
    (address.first_line + h.tag(:br)).html_safe
  end
  def city_state_zip
    ("#{address.city}, #{address.state} #{address.zip}" + h.tag(:br)).html_safe
  end
  def phone
    if address.phone.present?
      (h.content_tag :small do
        "P: #{address.phone}"
      end) + h.tag(:br)
    end
  end
  def fax
    if address.fax.present?
      h.content_tag :small do
        "F: #{address.fax}"
      end
    end
  end
end
