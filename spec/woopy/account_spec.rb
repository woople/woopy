require 'spec_helper'

describe Woopy::Account do

  before do
    @token = 'foo'
    Woopy(token: @token)
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post(   '/services/v1/accounts.json', request_headers(@token), account_response )
      mock.post(   '/services/v1/users.json', request_headers(@token), user_response )
      mock.post(   '/services/v1/ownerships.json', request_headers(@token), ownership_response )

      mock.put(    "/services/v1/accounts/restore.json?subdomain=foo", request_headers(@token), :ok )

      mock.get(    '/services/v1/accounts/1/users/1/employment.json', accept_request_headers(@token), employment_response )
      mock.get(    '/services/v1/accounts/1/employments.json', accept_request_headers(@token), employment_collection_response )
      mock.post(   '/services/v1/accounts/1/employments.json', request_headers(@token), employment_response )
      mock.delete( '/services/v1/accounts/1/employments/1.json', accept_request_headers(@token), employment_response )

      mock.put(   "/services/v1/accounts/1/users/1/update_roles.json?#{ roles_attributes.to_query }", request_headers(@token), :ok )
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

  describe "#restore!" do
    describe "archived account" do
      subject { Woopy::Account.restore!('foo') }

      it { should be_true }
    end
  end

  context "with an existing user" do
    before do
      @account = Woopy::Account.create(account_attributes)
      @user    = Woopy::User.create(user_attributes)
    end

    describe "#employ" do
      subject { @account.employ(@user) }

      it { should be_kind_of Woopy::Employment }
      it { should be_persisted }
    end

    describe "#unemploy" do
      before do
        @employment = @account.employ(@user)
      end

      subject { @account.unemploy(@employment) }

      it { should be_true }
    end

    describe "#make_owner" do
      subject { @account.make_owner(@user) }

      it { should be_kind_of Woopy::Ownership }
      it { should be_persisted }
    end

    describe "#find_employment" do
      subject { @account.find_employment(@user) }

      it { should be_kind_of Woopy::Employment }
      it { should be_persisted }
      its(:user_id) { should == @user.id }
    end

    describe "#grant_role" do
      subject { @account.grant_role(@user, ["role1", "role2"]) }

      it { should be_true }
    end

  end

  context "#employments" do
    context "users on account" do
      before do
        @account = Woopy::Account.create(account_attributes)
        @employments = add_users_to_account(@account)
      end

      subject { @account.employments }

      it { should == @employments }
    end
  end

  def add_users_to_account(account)
    employments = []
    user = Woopy::User.create(user_attributes)
    employment = account.employ(user)
    employments << employment
  end
end
