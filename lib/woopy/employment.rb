module Woopy
  class Employment < Resource
    def initialize(attributes = {}, persisted = false)
      self.class.site = Resource.site + "accounts/:account_id/"
      super(attributes, persisted)
    end
  end
end
