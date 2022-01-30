require 'csv'
require 'pry'

class DownloadError < Exception ; end

module Import
  class Pokemons
    attr_accessor :file_url, :file

    def initialize(file_url)
      @file_url = file_url
    end

    def import
      download_file
      parse_csv.each_slice(100) do |items|
        ImportWorker.perform_async(items.to_json)
      end
    end

    def cleanup
      download_file
      items_ids = parse_csv.map(&:id)
      CleanupWorker.perform_async(items_ids.to_json)
    end

    private

    def download_file
      begin
        @file = Down.download(file_url)
      rescue StandardError => exception
        Rails.logger.error(exception)
        raise Error.new("Failed to download file")
      end
    end

    def parse_csv
      begin
        csv_file = File.open(file.path)
        csv = CSV.parse(csv_file, :headers => true)
        csv.collect do |row|
          row.collect do |k,v|
            [ POKEMON_COLUMNS[k.to_sym], v ]
          end.to_h.symbolize_keys
        end
      rescue StandardError => exception
        Rails.logger.error(exception)
        raise Error.new("Could not parse CSV file")
      end
    end

  end
end
