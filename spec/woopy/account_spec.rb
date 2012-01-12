require 'spec_helper'

describe Woopy::Account do

  before do 
    @account_id = 1
    @token = 'foo'
    @subdomain = 'subdomain'
    @name = 'Account Name'
    Woopy(token: @token)
  end

  describe "#save" do

    before do
      path = '/services/v1/accounts.json'
      response_body = {account: { id: @account_id, name: @name, subdomain: @subdomain }}.to_json
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( path, request_headers(@token), response_body)
      end
    end

    context "valid name and subdomain" do
      before do
        @account = Woopy::Account.new(name: @name, subdomain: @subdomain) 
      end
      it 'saves correctly' do
        @account.save.should be_true
      end
    end

  end

end
