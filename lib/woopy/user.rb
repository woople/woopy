module Woopy
  class User < Resource

    def initialize(options)
      @token = options[:token]
      Resource.headers['X-WoopleToken'] = @token
    end
    
  end
end
