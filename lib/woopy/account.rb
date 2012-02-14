module Woopy
  class Account < Resource
    def employ(user, role = nil)
      Employment.create(account_id: self.id, user_id: user.id, role: role)
    end

    def unemploy(employment)
      employment.destroy
    end

    def make_owner(user, role = nil)
      Ownership.create(account_id: self.id, user_id: user.id, role: role)
    end

    def employments
      employment = Employment.find(:all, params: { account_id: self.id })
    end
  end
end
