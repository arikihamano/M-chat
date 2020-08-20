require 'csv'

CSV.generate do |csv|
  column_names = %w(name e-mail self-introduction)
  csv << column_names
  @users.each do |user|
    column_values = [
      user.name,
      user.email,
      user.self_introduction
    ]
    csv << column_values
  end

end
