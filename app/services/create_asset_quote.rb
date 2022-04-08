# frozen_string_literal: true

class CreateAssetQuote < ApplicationService
  def initialize(asset_symbol)
    @asset_symbol = asset_symbol
  end

  def call
    asset = Asset.find_by!(symbol: @asset_symbol)
    new_value = FetchAssetQuote.call(@asset_symbol).to_money.cents
    ActiveRecord::Base.transaction do
      Quote.where(asset:).update_all(current: false)
      Quote.create(asset:, price: new_value, current: true)
    end
  end
end
