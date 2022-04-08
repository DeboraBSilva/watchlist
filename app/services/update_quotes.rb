# frozen_string_literal: true

class UpdateQuotes < ApplicationService
  def call
    Asset.all.each do |asset|
      priority = WalletItem.find_by(asset: asset) ? :high : :default
      UpdateAssetQuoteWorker.set(queue: priority).perform_async(asset.symbol)
    end
  end
end
