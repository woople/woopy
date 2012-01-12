require 'spec_helper'

describe Woopy::User do

  before do 
    @token = 'foo'
    @user_id = 1
    @name = "Test User"
    @email = "test@example.com"
    @image_url = "/images/thumb/missing.png"
  end

  describe "#new" do
    before do
      path = '/services/v1/users'
      request_headers = {"Accept" => "application/json", "X-WoopleToken" => @token }
      response_body = {id: @user_id, name: @name, email: @email, image_url: @image_url}.to_json
      response_headers = { "Location" => "#{path}/#{@user_id}.json" }
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( path, request_headers, response_body, 200, response_headers )
      end
    end

    subject { Woopy::User.new(token: @token, name: @name, email: @email) }

    it { should be }
    
  end

  describe "#save" do

    before do
      path = '/services/v1/users'
      request_headers = {"Accept" => "application/json", "X-WoopleToken" => @token }
      response_body = {id: @user_id, name: @name, email: @email, image_url: @image_url}.to_json
      response_headers = { "Location" => "#{path}/#{@user_id}.json" }
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post( path, request_headers, response_body, 200, response_headers )
      end
      @user = Woopy::User.new(token: @token, name: @name, email: @email) 
    end

    subject { @user.save }

    it { should be }

    # its :id do 
    #   should be_eql(@user_id)
    # end

    # its :name do
    #   should be_eql(@name)
    # end

    # its :email do
    #   should be_eql(@email)
    # end

    # its :image_url do
    #   should be 
    # end
  end

end
