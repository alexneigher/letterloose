# run this like rake import_csv['uploads/letter_loose_game.csv']
task :import_csv, [:message] => :environment do |t, args|
  require 'csv'    

  path = args[:message]
  return unless path

  csv_text = File.read(path)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    
    user = User.find_by_email(row["User Name"].try(:downcase))
    category = Category.find_by_name(row['Category'])
    next unless user.present? && category.present?
    puts row.inspect
    title = Title.create(name: row["Original Title"].try(:gsub, '"',''), category_id: category.id, user_id: user.id)
    tweak = Tweak.create(name: row[' Title'].try(:gsub, '"',''), title_id: title.id, user_id: user.id)
    description = Description
                  .create(
                    text: row['Description of New Film'].try(:gsub, '"',''),
                    user_id: user.id,
                    tweak_id: tweak.id
                  )
  end


end