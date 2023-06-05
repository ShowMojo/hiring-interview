# frozen_string_literal: true

module ApplicationHelper
  def full_name(record)
    return unless record

    [record.first_name, record.last_name].join(' ')
  end
end
