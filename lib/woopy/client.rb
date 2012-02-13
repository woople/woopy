module Woopy

  DEFAULT_SITE_BASE = "https://api.woople.com/services/v1/"

  class Client
    def initialize(options)
      @token = options[:token]
      Resource.headers['X-WoopleToken'] = @token
      Resource.site = options[:site] || DEFAULT_SITE_BASE
    end

    def verify
      Resource.connection.get(Resource.prefix + 'verify', Resource.headers).success?
    end

  end
end
