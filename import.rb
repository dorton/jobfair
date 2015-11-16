require 'csv'

csv_text = File.read('/Users/dorton/Desktop/import.csv')

csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
   User.create!(row.to_hash)
end
