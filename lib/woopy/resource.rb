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

      def build_subclass
        returning Class.new(self) do |c|
          c.element_name    = self.element_name
          c.collection_name = self.collection_name
          c.primary_key     = self.primary_key
        end
      end
    end
  end
end