class User < ActiveRecord::Base
    has_many :assets
    has_many :collectibles, :through => :assets
    has_secure_password
    def self.balanceToString(account)
      flbal = account.balance
      dec = flbal%1
      if (dec*100)%10 == 0 #and dec != 0
        return "$#{flbal}0"
      else
        return "$#{flbal}"
      end
    end
end
