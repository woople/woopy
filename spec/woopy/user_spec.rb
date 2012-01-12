require 'spec_helper'

describe Woopy::User do

  before do 
    @token = 'foo'
    @user_id = 1
    @name = "Test User"
    @email = "test@example.com"
    Woopy(token: @token)
  end

  describe "#save" do

    before do
      path = '/services/v1/users.json'
      response_body = {user: { id: @user_id, name: @name, email: @email }}.to_json
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( path, request_headers(@token), response_body)
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
