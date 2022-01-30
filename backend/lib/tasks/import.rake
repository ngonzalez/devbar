require_relative '../import/csv'

namespace :data do
  desc "Import CSV file from URL"
  task :import, [:file_url] => :environment do |t, args|
    Import::Pokemon.new(args[:file_url]).import
  rescue StandardError => exception
    raise Error.new("Could not process CSV file: %s" % [exception.message])
  end

  desc "Cleanup CSV file from URL"
  task :cleanup, [:file_url] => :environment do |t, args|
    Import::Pokemon.new(args[:file_url]).cleanup
  rescue StandardError => exception
    raise Error.new("Could not process CSV file: %s" % [exception.message])
  end
end
