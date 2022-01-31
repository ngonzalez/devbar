class CleanupWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform(item_ids_json)
    Rails.logger.info(item_ids_json.inspect)
    item_ids = JSON.parse(item_ids_json)
    Pokemon.where(['item_id IS NULL OR item_id NOT IN (?)', item_ids]).destroy_all
  rescue => exception
    Rails.logger.error(exception)
  end
end
