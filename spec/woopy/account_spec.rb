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

  describe "#employ" do
    before do
      user_name = "Test User"
      email = "mail@empl.com"
      account_response = {account: { id: @account_id, name: @name, subdomain: @subdomain }}.to_json
      user_response = {user: { id: 1, name: user_name, email: email }}.to_json
      employments_response = {employment: { id: 1, user_id: 1, account_id: @account_id}}.to_json
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( '/services/v1/accounts.json', request_headers(@token), account_response )
        mock.post( '/services/v1/users.json', request_headers(@token), user_response )
        mock.post( '/services/v1/employments.json', request_headers(@token), employments_response )
      end
      @account = Woopy::Account.create(name: @name, subdomain: @subdomain) 
      @user = Woopy::User.create(name: user_name, email: email)
    end

    subject { @account.employ(@user) }

    it { should be_kind_of Woopy::Employment }
    it { should be_persisted }

  end

end
