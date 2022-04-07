class UpdateAssetQuoteWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(asset_symbol)
    CreateAssetQuote.call(asset_symbol)
  end
end
