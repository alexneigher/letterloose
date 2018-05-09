# run this like rake import_songs_csv['uploads/songs.csv']
task :import_songs_csv, [:message] => :environment do |t, args|
  require 'csv'

  path = args[:message]
  return unless path

  csv_text = File.read(path)
  csv = CSV.parse(csv_text)
  csv.each do |row|
    user = User.find_by_username(row[1])
    category = Category.find_by_name('Song Titles')
    if user.present? && category.present?
      Title.create(category: category, name: row[0], user: user)
    end
  end

end
