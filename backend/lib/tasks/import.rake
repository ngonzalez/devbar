require_relative '../import/csv'

namespace :data do
  desc "Import CSV file from URL"
  task :import, [:file_url] => :environment do |t, args|
    Import::Pokemons.new(args[:file_url]).import
  rescue => _exception
    Rails.logger.error _exception
  end
end