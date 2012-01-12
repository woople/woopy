module Woopy
  class Account < Resource

    def employ(user)
      Employment.create(account_id: self.id, user_id: user.id)
    end

  end
end
