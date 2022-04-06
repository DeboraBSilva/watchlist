class AssetQuote < ApplicationService
  def initialize(asset_symbol)
    @asset_symbol = asset_symbol
  end

  def call
    asset = Asset.find_by!(symbol: @asset_symbol)
    new_value = Crawler.call(@asset_symbol).to_money.cents
    Quote.where(asset: asset).update_all(current: false)
    Quote.create(asset: asset, price: new_value, current: true)
  end
end
