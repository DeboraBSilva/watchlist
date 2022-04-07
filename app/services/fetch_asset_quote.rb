require 'nokogiri'
require 'httparty'

class FetchAssetQuote < ApplicationService
  SOURCE_URL_FOR_QUOTES = 'https://statusinvest.com.br/acoes/'

  def initialize(asset_symbol)
    @asset_symbol = asset_symbol.downcase
  end

  def call
    asset_value
  end
  
  private

  def asset_value
    document = Nokogiri::HTML.parse(HTTParty.get("#{SOURCE_URL_FOR_QUOTES}#{@asset_symbol}").body)
      .css('div.special')
    currency = document.css('span.icon').map(&:text).first
    value = document.css('strong.value').text
    response = "#{currency} #{value}"
    raise "Asset not found" if response.blank?
    response
  end
end
