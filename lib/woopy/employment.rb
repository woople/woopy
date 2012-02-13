module Woopy
  class Employment < Resource

    def initialize(options)
      self.class.site = "#{Resource.site}users/:user_id/employments"
      super(options)
    end

    #self.set_prefix "/services/v1/accounts/:account_id/"
    #self.site = self.site + "/accounts/:account_id/"
    #
    def all
      self.site += self.site + "/whatever"
    end
  end


end
