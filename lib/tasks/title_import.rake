# run this like rake import_titles_csv['uploads/titles.csv']
task :import_titles_csv, [:message] => :environment do |t, args|
  require 'csv'

  path = args[:message]
  return unless path

  csv_text = File.read(path)
  csv = CSV.parse(csv_text, encoding:'iso-8859-1:utf-8')
  csv.each do |row|
    user = User.find_by_username(row[1])
    category = Category.find_by_name('Film Titles')
    if user.present? && category.present?
      Title.create(category: category, name: row[0], user: user)
    end
  end

end
