require 'watir-webdriver'
require 'nokogiri'
require './web_warcards_app'


module HasBrowser
  @@browser = Watir::Browser.new :chrome
  at_exit { @@browser.close }

  def browser
    @@browser
  end
end

World HasBrowser