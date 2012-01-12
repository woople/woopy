require 'spec_helper'

describe Woopy::User do

  before do 
    @token = 'foo'
    @user_id = 1
    @name = "Test User"
    @email = "test@example.com"
    Woopy(token: @token)
  end

  describe "#new" do
    subject { Woopy::User.new(name: @name, email: @email) }

    it 'sets a token' do
      Woopy::User.headers["X-WoopleToken"].should eql(@token)
    end

    it { should be_kind_of Woopy::User }
    
  end

  describe "#save" do

    before do
      path = '/services/v1/users.json'
      request_headers = {"Content-Type" => "application/json", "X-WoopleToken" => @token }
      response_body = {user: { id: @user_id, name: @name, email: @email }}.to_json
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( path, request_headers, response_body)
      end
    end

    context "valid name and email" do
      before do
        @user = Woopy::User.new(name: @name, email: @email) 
      end
      it 'saves correctly' do
        @user.save.should be_true
      end
    end

  end

end
