# frozen_string_literal: true

class UpdateQuotes < ApplicationService
  def call
    asset_ids = WalletItem.distinct.pluck(:asset_id)

    Asset.all.each do |asset|
      priority = asset_ids.include? asset.id ? :high : :default
      UpdateAssetQuoteWorker.set(queue: priority).perform_async(asset.symbol)
    end
  end
end
