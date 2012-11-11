class SpecialtyDecorator < Draper::Base
  decorates :specialty

  def specialization
    render_if_present :specialization
  end

  def classification
    render_if_present :classification
  end

  def type
    render_if_present :type
  end

  def render_if_present property
    value = specialty.send(property)
    if value.present?
      value + h.tag(:br)
    else
      ""
    end.html_safe
  end
end
