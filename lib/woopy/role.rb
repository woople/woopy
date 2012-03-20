module Woopy
  class Role < Resource
    def initialize(attributes = {}, persisted = false)
      self.class.site = Resource.site + "accounts/:account_id/users/:user_id/"
      super(attributes, persisted)
    end
  end
end
