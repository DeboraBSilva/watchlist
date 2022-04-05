require 'nokogiri'
require 'httparty'

class Crawler < ApplicationService
  def initialize(asset_symbol)
    @asset_symbol = asset_symbol.downcase
  end

  def call
    asset_value
  end
  
  private

  def asset_value
    Nokogiri::HTML.parse(HTTParty.get("https://statusinvest.com.br/acoes/#{@asset_symbol}"))
      .css('div.special')
      .css('strong.value')
      .text
  end
end
