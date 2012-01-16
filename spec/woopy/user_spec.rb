require 'spec_helper'

describe Woopy::User do
  before do 
    @token = 'foo'
    Woopy(token: @token)
  end

  describe "#save" do
    context "valid name and email" do
      before do
        ActiveResource::HttpMock.respond_to do |mock|
          mock.post( '/services/v1/users.json', request_headers(@token), user_response)
        end
        @user = Woopy::User.new(user_attributes) 
      end

      it 'saves correctly' do
        @user.save.should be_true
      end
    end
    
    context "invalid attributes" do
      before do
        ActiveResource::HttpMock.respond_to do |mock|
          mock.post('/services/v1/users.json', request_headers(@token), { errors: ["Name can't be blank"] }.to_json, 422)
        end
        @user = Woopy::User.new(user_attributes) 
      end
      
      it "should not save, with errors" do
        @user.save.should be_false
        @user.errors.full_messages.should include("Name can't be blank")
      end
    end
  end
end
