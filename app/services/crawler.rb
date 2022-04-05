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
    document = Nokogiri::HTML.parse(HTTParty.get("https://statusinvest.com.br/acoes/#{@asset_symbol}"))
      .css('div.special')
    currency = document.css('span.icon').map(&:text).first
    value = document.css('strong.value').text
    response = "#{currency} #{value}"
    raise "Not valid" if response.blank?
    response
  end
end
