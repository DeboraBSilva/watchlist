class UpdateQuotes < ApplicationService
  def call
    Asset.all.each do |asset| 
      UpdateAssetQuoteWorker.perform_async(asset.symbol)
    end 
  end
end
