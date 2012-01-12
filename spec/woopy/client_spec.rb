require 'spec_helper'

describe Woopy::Client do
  before { @token = 'foo' }

  describe '#new' do
    it "sets the header token" do
      Woopy(token: @token)
      Woopy::Resource.headers['X-WoopleToken'].should eq(@token)
    end
  end

  describe '#verify' do
    
    context 'given valid token' do
      before { mock_verify(200) }
      
      subject { Woopy(token: @token).verify }
      
      it { should be_true }
    end
    
    context 'given invalid token' do
      before { mock_verify(401) }
      
      subject { Woopy(token: @token).verify }
      
      it { expect { subject }.to raise_error }
    end
  end
  
  def mock_verify(status_code)
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/services/v1/verify', {"Accept" => "application/json", "X-WoopleToken" => @token }, '', status_code
    end
  end
end
