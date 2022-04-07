require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!
RSpec.describe UpdateAssetQuoteWorker, type: :worker do
  describe '.call' do
    before do
      @asset = Asset.create(symbol: 'PETR4', currency: 'BRL')
    end
    
    it 'creates a worker' do
      expect do
        described_class.perform_async(@asset.symbol)
      end.to change(described_class.jobs, :size).by(1)
      described_class.new.perform(@asset.symbol)
    end
  end
end
