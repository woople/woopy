module Woopy
  class Client
    def initialize(options)
      @token = options[:token]
      Resource.headers['X-WoopleToken'] = @token
    end
    
    def verify
      Resource.connection.get(Resource.prefix + 'verify', Resource.headers).code == 200
    end
  end
end