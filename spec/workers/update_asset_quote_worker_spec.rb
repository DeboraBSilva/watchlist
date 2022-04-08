require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UpdateAssetQuoteWorker, type: :worker do
  before do
    Sidekiq::Testing.fake!
  end

  describe '.call' do
    let(:asset) { Asset.create(symbol: 'PETR4', currency: 'BRL') }
    
    it 'creates a worker' do
      expect do
        described_class.perform_async(asset.symbol)
      end.to change(described_class.jobs, :size).by(1)
    end
  end
end
