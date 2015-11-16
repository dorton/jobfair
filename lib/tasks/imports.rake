require 'csv'

desc "Import Users from csv file"
task :import => [:environment] do

  file = "lib/tasks/aiga.csv"

  CSV.foreach(file, :headers => true) do |row|
    User.create!
  end

end
