require 'csv'

namespace :collect_data do
  desc 'Collect product paths in a file'
  task :product_links do
    base_url = 'https://www.gurneys.com'
    categories = ['/vegetables', '/fruits-and-berries', '/flower-seeds-and-bulbs']
    product_links_file = File.open(Rails.root.join('lib', 'seeds', 'product_links.txt'), 'w')
    browser = Watir::Browser.new

    sub_category_links = categories.map do |category|
      href = '/category' + category
      response = Faraday.get(base_url + href)
      raw_category_data = Nokogiri::HTML(response.body)

      raw_category_data
        .css('.pcat, .open')
        .css('ul')
        .css('a')
        .map {|link| link['href']}
    end.flatten

    product_links = sub_category_links.each do |sub_category|
      response = browser.goto(base_url + sub_category)

      js_doc = browser.element(css: '.ss-results').wait_until(&:present?)
      doc = Nokogiri::HTML5(js_doc.inner_html)
      doc.css('.producttile').css('a.tileimage').each do |link|
        product_links_file.puts link['href']
      end
    end
  end

  desc 'Create a json file of seed data'
  task :seeds do
    base_url = 'https://www.gurneys.com'
    product_links_path = Rails.root.join('lib', 'seeds', 'product_links.txt')
    seed_data_file = File.open(Rails.root.join('lib', 'seeds', 'seed_data.json'), 'w')

    File.foreach(product_links_path, chomp: true) do |product_link|
      response = Faraday.get(base_url + product_link)
      raw_category_data = Nokogiri::HTML(response.body)
      product_data = raw_category_data.css('div#proddetails').css('div.detailsections').css('li')
        
      product = product_data.reduce({}) do |aggregator, attribute|
        key, value = attribute.css('span').map(&:text)
        key = key.downcase.gsub(' ', '_').chomp(':').to_sym
        aggregator[key] = value
        aggregator
      end

      product[:name] = raw_category_data.css('.mainprodname').first.text.strip
      product[:category] = raw_category_data
        .css('#breadcrumb')
        .css('a')[-1]['href']
        .split('/')
        .last
        .downcase
        .gsub('-', '_')

      next if !product[:botanical_name]
      seed_data_file.puts product.to_json
    end
  end

  desc 'Get last frost dates'
  task :frost_dates do
    zones_csv = Rails.root.join('lib', 'seeds', 'zipcodes.csv')
    base_url = 'https://www.almanac.com/gardening/frostdates/zipcode/'

    hardiness_zones_file = File.open(Rails.root.join('lib', 'seeds', 'hardiness_zones_2.json'), 'w')

    File.open(zones_csv) do |file|
      headers = file.first
      file.each_slice(500) do |lines|
        csv_rows = CSV.parse(lines.join, headers: headers)
        csv_rows.each_with_index do |zone, index|
          zone = zone.to_h
          zone.merge!({last_frost: nil, last_frost_short: nil})
          response = Faraday.get(base_url + zone['zipcode'])
          data = Nokogiri::HTML(response.body)
          begin
            zone[:last_frost] = data.css('#frostdates_table').css('td')[2].text
            zone[:last_frost_short] = Time.strptime(zone[:last_frost], '%b %d').strftime('%m/%d/%Y')
          rescue
            puts "\nIssues on #{zone['zipcode']}"
          end

          hardiness_zones_file.puts zone.to_json
          printf("\rProgress: #{(index/500.0) * 100}")
        end
      end
    end
  end
end