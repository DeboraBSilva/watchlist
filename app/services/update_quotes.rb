# frozen_string_literal: true

class UpdateQuotes < ApplicationService
  def call
    Asset.includes(:wallet_items).all.each do |asset|
      priority = asset.wallet_items.present? ? :high : :default
      UpdateAssetQuoteWorker.set(queue: priority).perform_async(asset.symbol)
    end
  end
end
