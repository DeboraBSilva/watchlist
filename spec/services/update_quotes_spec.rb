# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UpdateQuotes do
  before do
    Sidekiq::Testing.fake!
  end

  describe '.call' do
    let(:asset) { Asset.create(symbol: 'PETR4', currency: 'BRL') }
    let(:user) { User.create!(email: 'user@test.com', password: 'password') }
    let(:wallet) { Wallet.create!(user: user) }

    context 'when asset belongs to watchlist' do
      let!(:wallet_items) { WalletItem.create(wallet: wallet, asset: asset) }
      let(:fake) { double(perform_async: true) }

      before do
        allow(UpdateAssetQuoteWorker).to receive(:set).and_return(fake)
      end
    
      it 'adds to the high priority queue' do
        expect(UpdateAssetQuoteWorker)
          .to receive(:set)
          .with(queue: :high)

        expect(fake).to receive(:perform_async).with(asset.symbol)
        UpdateQuotes.call
      end
    end

    context 'when asset does not belong to watchlist' do
      let(:fake) { double(perform_async: true) }

      before do
        allow(UpdateAssetQuoteWorker).to receive(:set).and_return(fake)
      end
    
      it 'adds to the default priority queue' do
        expect(UpdateAssetQuoteWorker)
          .to receive(:set)
          .with(queue: :default)

        expect(fake).to receive(:perform_async).with(asset.symbol)
        UpdateQuotes.call
      end
    end
  end
end
