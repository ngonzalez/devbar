class ImportWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  attr_accessor :factory

  def perform(items_json)
    Rails.logger.info(items_json.inspect)
    items_attributes = JSON.parse(items_json)
    items_attributes.each do |item|
      begin
        Rails.logger.info(item.inspect)
        pokemon = Pokemon.find_by(name: item['name']) || Pokemon.new
        pokemon.attributes = item
        pokemon.save!
      rescue StandardError => exception
        Rails.logger.error(exception)
        next
      end
    end
  end
end
