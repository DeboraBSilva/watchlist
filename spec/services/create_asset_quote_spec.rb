# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateAssetQuote do
  describe '.call' do
    context 'when asset exists' do
      context 'and is found' do
        let(:asset) { Asset.create(symbol: 'PETR4', currency: 'BRL') }

        it 'creates new quote' do
          expect { described_class.call(asset.symbol) }.to change(Quote, :count).by(1)
        end
      end

      context 'and is not found' do
        let(:asset) { Asset.create(symbol: 'ZXCV', currency: 'BRL') }

        it 'raises an error' do
          expect { described_class.call(asset.symbol) }.to raise_error('Asset not found')
        end
      end
    end

    context 'when asset does not exists' do
      it 'raises an error' do
        expect { described_class.call('') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
