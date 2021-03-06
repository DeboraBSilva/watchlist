# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy, class_name: 'WalletItem'
end
