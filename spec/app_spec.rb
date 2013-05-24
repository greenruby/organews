require 'spec_helper'

describe 'App general behaviour' do
  include Rack::Test::Methods

  it 'responds to homepage' do
    get '/'
    last_response.should be_ok
  end

end