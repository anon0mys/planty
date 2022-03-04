desc 'Set the active flag on the Layout data'
task set_seed_planting_dates: :environment do
  seeds = Seed.where(planting_date: nil)
  puts "There are #{seeds.count} seeds without planting dates"
  puts "In categories: #{seeds.pluck(:category).uniq}"

  CSV.foreach(Rails.root.join('lib', 'seeds', 'start_dates.txt'), headers: true) do |row|
    category = row['category'].downcase
    seeds_in_category = seeds.where('category ILIKE ?', "%#{category}%")
    if seeds_in_category.exists?
      puts "Updating #{seeds_in_category.count} seeds in #{seeds_in_category.first.category}"
      seeds_in_category.update_all(planting_date: row['start_date'])
    else
      puts "No seeds match category: #{category}"
    end

    seeds_with_similar_name = seeds.where('name ILIKE ?', "%#{category}%")
    if seeds_with_similar_name.exists?
      puts "Updating #{seeds_with_similar_name.count} seeds that have names like #{category}"
      seeds_with_similar_name.update_all(planting_date: row['start_date'])
    else
      puts "No seeds have names like: #{category}"
    end
  end

  remaining_seeds = Seed.where(planting_date: nil)
  puts "There are #{remaining_seeds.count} seeds without planting dates"
  puts "Remaining categories: #{remaining_seeds.pluck(:category).uniq}"
end