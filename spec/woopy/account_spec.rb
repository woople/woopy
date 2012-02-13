require 'spec_helper'

describe Woopy::Account do

  before do
    @token = 'foo'
    Woopy(token: @token)
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post( '/services/v1/accounts.json', request_headers(@token), account_response )
      mock.post( '/services/v1/users.json', request_headers(@token), user_response )
      mock.post( '/services/v1/accounts/1/employments.json', request_headers(@token), employment_response )
      #mock.post( '/services/v1/accounts/1/employments.json', request_headers(@token), employment_response )
      mock.post( '/services/v1/ownerships.json', request_headers(@token), ownership_response )
    end
  end

  describe "#save" do

    context "valid name, subdomain, and packages" do
      before do
        @account = Woopy::Account.new(account_attributes)
      end
      it 'saves correctly' do
        @account.save.should be_true
      end
    end

  end

  context "with an existing user" do

    before do
      @account = Woopy::Account.create(account_attributes)
      @user = Woopy::User.create(user_attributes)
    end

    describe "#employ" do
      subject { @account.employ(@user) }

      it { should be_kind_of Woopy::Employment }
      it { should be_persisted }
    end

    describe "#make_owner" do
      subject { @account.make_owner(@user) }

      it { should be_kind_of Woopy::Ownership }
      it { should be_persisted }
    end

  end

end
