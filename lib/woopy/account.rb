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

    def find_employment(user)
      employment_json = Account.get("#{self.id}/users/#{user.id}/employment")

      Employment.new(employment_json, true)
    end
  end
end