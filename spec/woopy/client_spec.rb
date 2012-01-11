require 'spec_helper'
require 'woopy'

describe Woopy::Client do
  it "should do something" do
    true.should eq(true)
  end

  describe '#verified?' do
    context 'given valid token' do
      before do
        @token = 'foo'
        @headers = { 'X-WoopleToken:' => @token }
        ActiveResource::HttpMock.respond_to do |mock|
          mock.get '/services/v1/verify', @headers, '', 200
        end
      end
      
      subject { Woopy(token: @token) }
      
      it "should set the token header" do
        client = Woopy(token: @token)
        Woopy::Resource.headers['X-WoopleToken'].should eq(@token)
      end

      it { should be_verified }
      
    end
    
    # context 'given invalid token' do
    #   before do
    #     @token = 'foo'
    #     @headers = { 'X-WoopleToken:' => @token, 'Accept' => 'application/json' }
    #     ActiveResource::HttpMock.respond_to do |mock|
    #       mock.get '/services/v1/verify', @headers, '', 401
    #     end
    #   end
    #   
    #   subject { Woopy(token: @token) }
    #   
    #   it { should_not be_verified }
    # end
  end
end