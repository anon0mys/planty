require 'csv'

zones_file = Rails.root.join('lib', 'seeds', 'hardiness_zones.json')

File.open(zones_file) do |file|
  headers = file.first
  file.lazy.each_slice(500) do |lines|
    lines.map do |zone|
      zone = JSON.parse(zone)
      Rails.cache.redis.set(zone['zipcode'], zone.to_json)
    end
  end
end

if !Seed.exists?
  File.foreach(Rails.root.join('lib', 'seeds', 'seed_data.json')) do |line|
    seed_data = JSON.parse(line)
    Seed.create!(seed_data)
  end
  puts "Created #{Seed.count} seeds"
end

if !AdminUser.find_by(email: 'admin@example.com') && Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  puts "Created Demo Admin User"
end
