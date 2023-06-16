module ApplicationHelper
  def full_name(record)
    "#{record.first_name} #{record.last_name}"
  end
end
