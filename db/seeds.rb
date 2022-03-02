require 'csv'

if !HardinessZone.exists?
  zones_csv = Rails.root.join('lib', 'seeds', 'phm_us_zipcode.csv')

  # CSV.foreach(zones_csv, headers: true) { |row| HardinessZone.create!(row) }
  File.open(zones_csv) do |file|
    headers = file.first
    file.lazy.each_slice(500) do |lines|
      csv_rows = CSV.parse(lines.join, headers: headers)
      HardinessZone.insert_all!(csv_rows.map(&:to_h))
    end
  end
  puts "Created #{HardinessZone.count} zones"
end

if !AdminUser.find_by(email: 'admin@example.com')
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
  puts "Created Demo Admin User"
end
