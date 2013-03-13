$:<< File.expand_path('../..',__FILE__)

require 'greeby'
require 'rspec'
require "rack/test"

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
ENV['RACK_ENV'] = 'test'


describe 'Greeby general behaviour' do
  include Rack::Test::Methods

  def app
    Greeby
  end

  it 'responds to homepage' do
    get '/'
    last_reponse.should be_ok
  end

end