require 'watir-webdriver'
require 'nokogiri'
require './web_warcards_app'
require 'open-uri'


module HasBrowser
  @@browser = Watir::Browser.new :chrome
  at_exit { @@browser.close }

  def browser
    @@browser
  end
end

World HasBrowser