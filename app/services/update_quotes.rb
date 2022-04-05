class UpdateQuotes < ApplicationService
  def call
    Asset.all.each do |asset| 
      SearchAssetQuoteWorker.perform_async(asset.symbol)
    end 
  end
end
