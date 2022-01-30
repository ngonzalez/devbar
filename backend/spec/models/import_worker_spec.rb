require 'rails_helper'
require Rails.root + 'lib/import/csv'

RSpec.describe Import::Pokemon, type: :model do
  context 'setup test environment' do
    it 'should import a file' do
      # No Pokemon exist at this point
      expect(Pokemon.count).to eq(0)

      # Initial import of 800 Pokemon
      file_url = 'https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv'
      source = Import::Pokemon.new(file_url)
      source.send :download_file
      expect(source.file.collect.count).to eq(801)
      ImportWorker.new.perform(source.send(:parse_csv).to_json)
      expect(Pokemon.count).to eq(721)
    end
  end
end
