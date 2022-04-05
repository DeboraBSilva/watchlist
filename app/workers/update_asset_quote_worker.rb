class UpdateAssetQuoteWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(asset_symbol)
    AssetQuote.call(asset_symbol)
  end
end
