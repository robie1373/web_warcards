require "./web_warcards_app"
require "minitest/spec"
require "rack/test"

set :environment, :test

describe "web_warcards_app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    last_response.should.be.ok
    last_response.should.equal 'hello'
  end
end