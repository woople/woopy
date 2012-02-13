module Woopy
  class Employment < Resource
    def initialize(options)
      self.class.site = Resource.site + "accounts/:account_id/"
      super(options)
    end
  end
end