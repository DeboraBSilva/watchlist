require 'rails_helper'

RSpec.describe AssetQuote do
  describe '.call' do
    before do
      @asset = Asset.create(symbol: 'PETR4', currency: 'BRL')
    end

    it 'creates new quote' do
      expect { described_class.call(@asset.symbol) }.to change(Quote, :count).by(1)
    end
  end
end
