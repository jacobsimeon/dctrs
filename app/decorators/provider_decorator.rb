class ProviderDecorator < Draper::Base
  decorates :provider

  def header &block
    h.content_tag(:div, {class: 'header'}, &block)
  end

  def body &block
    h.content_tag(:div, {}, &block)
  end

  def container &block
    h.content_tag(:div, class: 'row provider-wrapper') do
      h.content_tag(:div, { id: provider.npi, class: 'provider clearfix span9 offset1' }, &block)
    end
  end

  def address
    h.content_tag(:address, class: "pull-left") do
      yield AddressDecorator.decorate(provider.practice_location)
    end
  end

  def specialty
    h.content_tag(:div, { class: 'specialty pull-right' }) do
      yield SpecialtyDecorator.decorate(provider.primary_specialty)
    end
  end

  def get_name
    if provider.entity_type == "individual"
      provider.name.first + " " + provider.name.last
    else
      provider.name.legal_business_name
    end
  end

  def name
    h.content_tag(:strong, { class: 'name' }) do
      h.link_to get_name, h.provider_path(provider.npi)
    end
  end

  def npi
    h.link_to provider.npi, h.provider_path(provider.npi), class: "npi pull-right"
  end
end
