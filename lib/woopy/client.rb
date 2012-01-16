module Woopy
  class Client
    def initialize(options)
      @token = options[:token]
      Resource.headers['X-WoopleToken'] = @token

      configure_end_point
    end

    def verify
      Resource.connection.get(Resource.prefix + 'verify', Resource.headers).code == 200
    end

    private

    def configure_end_point
      case current_environment
      when "production"
        Resource.site = "https://api.woople.com/services/v1/"
      when "staging"
        Resource.site = "https://api.testwoople.com/services/v1/"
      else
        Resource.site = "https://api.woople.local:8080/services/v1/"
      end
    end

    def current_environment
      ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"
    end
  end
end