# run this like rake import_phrases_csv['uploads/phrases.csv']
task :import_phrases_csv, [:message] => :environment do |t, args|
  require 'csv'

  path = args[:message]
  return unless path

  csv_text = File.read(path)
  csv = CSV.parse(csv_text)
  category = Category.find_by_name('Short Phrases')

  csv.each do |row|
    user = User.find_by_username('nougatcenter')

    if user.present?
      Title.create(category: category, name: row[0].to_s, user: user)
    end
  end

end
