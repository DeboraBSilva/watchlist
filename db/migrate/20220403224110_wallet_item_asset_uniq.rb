# frozen_string_literal: true

class WalletItemAssetUniq < ActiveRecord::Migration[7.0]
  def change
    add_index :wallet_items, %i[asset_id wallet_id], unique: true
  end
end
