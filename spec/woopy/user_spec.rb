require 'spec_helper'

describe Woopy::User do

  before do 
    @token = 'foo'
    Woopy(token: @token)
  end

  describe "#save" do

    before do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( '/services/v1/users.json', request_headers(@token), user_response)
      end
    end

    context "valid name and email" do
      before do
        @user = Woopy::User.new(user_attributes) 
      end
      it 'saves correctly' do
        @user.save.should be_true
      end
    end

  end

end
