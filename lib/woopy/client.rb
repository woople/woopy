module Woopy
  class Client
    def initialize(options)
      @token = options[:token]
      Resource.headers['X-WoopleToken'] = @token
    end
    
    def verified?
      Resource.connection.get(Resource.prefix + 'verify', Resource.headers)
    end
  end
end