module Woopy
  SITE_BASE = 'https://api.woople.com/services/v1/'
  
  class Resource < ActiveResource::Base
    Resource.site = SITE_BASE
    
    class << self
      # If headers are not defined in a given subclass, then obtain headers from the superclass.
      # Taken from the Harvest gem: github.com/aiaio/harvest
      def headers
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          @headers ||= {}
        end
      end
    end
  end
end