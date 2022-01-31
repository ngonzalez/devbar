require 'rails_helper'
require Rails.root + 'lib/import/csv'
require 'pry'

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
      expect(Pokemon.count).to eq(800)

      # Another Pokemon is created
      pokemon_attributes = { "item_id"=>"1111", "name"=>"test", "type_1"=>"Fire", "type_2"=>"Water", "total"=>"600", "hp"=>"80", "attack"=>"110", "defense"=>"120", "sp_atk"=>"130", "sp_def"=>"90", "speed"=>"70", "generation"=>"6", "legendary"=>"True" }
      pokemon = Pokemon.create!(pokemon_attributes)
      expect(pokemon).to be_instance_of(Pokemon)

      # A cleanup is called right after and the count is back to normal,
      # the Pokemon is removed because it's not part of the initial import of file_url
      item_ids = source.send(:parse_csv).map { |item| item[:id] }
      CleanupWorker.new.perform(item_ids.to_json)
      expect(Pokemon.only_deleted.map(&:name).sort).to eq(['test'])
    end
  end
end
