require 'csv'

module Import
  class Pokemons
    attr_accessor :url

    def initialize(file_url)
      @url = file_url
    rescue StandardError => _exception
      Rails.logger.error _exception
      raise Error.new("Failed to import CSV file")
    end

    def import
      file = Down.download(url)
      parse_csv(file.path).each_slice(100) do |items|
        ImportWorker.perform_async(items.to_json)
      end
    end

    def cleanup
      file = Down.download(url)
      items_ids = parse_csv(file.path).map(&:id)
      CleanupWorker.perform_async(items_ids.to_json)
    end

    def parse_csv(file_path)
      csv_file = File.open(file_path)
      csv = CSV.parse(csv_file, :headers => true)
      csv.collect do |row|
        row.collect do |k,v| [
          POKEMON_COLUMNS[k.to_sym], v ]
        end.to_h.symbolize_keys
      end
    end

  end
end
