require 'spec_helper'

describe Woopy::Client do
  before { @token = 'foo' }

  describe '#new' do
    it "sets the header token" do
      Woopy(token: @token)
      Woopy::Resource.headers['X-WoopleToken'].should eq(@token)
    end

    context "production environment" do
      before do
        ENV["RAILS_ENV"] = "production"
        Woopy(token: @token)
      end

      it "sets the end point" do
        Woopy::Resource.site.to_s.should eq("https://api.woople.com/services/v1/")
      end
    end

    context "staging environment" do
      before do
        ENV["RAILS_ENV"] = "staging"
        Woopy(token: @token)
      end

      it "sets the end point" do
        Woopy::Resource.site.to_s.should eq("https://api.testwoople.com/services/v1/")
      end
    end

    context "local development environment" do
      before do
        ENV["RAILS_ENV"] = "development"
        Woopy(token: @token)
      end

      it "sets the end point" do
        Woopy::Resource.site.to_s.should eq("https://api.woople.local:8080/services/v1/")
      end
    end

    context "undefined environment" do
      before do
        ENV["RAILS_ENV"] = nil
        Woopy(token: @token)
      end

      it "sets the default end point" do
        Woopy::Resource.site.to_s.should eq("https://api.woople.local:8080/services/v1/")
      end
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
