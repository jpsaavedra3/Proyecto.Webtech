module ApplicationHelper
  def field_class(record, attribute, base = "form-control")
    record.errors[attribute].any? ? "#{base} is-invalid" : base
  end

  def field_error(record, attribute)
    return if record.errors[attribute].empty?

    tag.div(record.errors[attribute].to_sentence, class: "invalid-feedback d-block")
  end
end
