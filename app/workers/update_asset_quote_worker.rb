class UpdateAssetQuoteWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(asset_symbol)
    CreateAssetQuote.call(asset_symbol)
  end
end
