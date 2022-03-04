FactoryBot.define do
  factory :seed do
    botanical_name { "Lycopersicon lycopersicum 'San Marzano'" }
    height { "4 feet. Indeterminate. " }
    spacing { "18 - 24 inches between plants, 3 - 5 feet between rows." }
    depth { "Plant seeds 1/4 inch deep." }
    spread { "2 - 3 feet." }
    light_required { "Full Sun" }
    pollinator { "Self pollinating." }
    add_attribute(:yield) { "Heavy yields." }
    color { "Green" }
    size { "25 Seed Pkt" }
    blooms { "April- May" }
    fruit { "Elongated, red fruits, meaty and very flavorful." }
    days_to_maturity { "85 Days" }
    zone { "3-9" }
    germination { "7 - 10 Days" }
    form { "Vegetable, Tomato, Heirloom Tomato, Indeterminate" }
    flower_form { "Yellow flowers." }
    soil_requirements { "Well-drained, deep fertile soil." }
    growth_rate { "Moderate growth rate." }
    seed_count { "Approximately 25 seeds per packet." }
    pruning { "Fruit ripens earlier since the sun can reach it more easily." }
    foliage { "Green foliage." }
    name { "San Marzano Tomato" }
    category { "open_pollinated_tomatoes" }
    planting_date { "1 to 2 weeks before" }
  end
end
