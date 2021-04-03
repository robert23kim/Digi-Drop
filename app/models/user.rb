class User < ActiveRecord::Base
    has_many :assets
    has_many :collectibles, :through => :assets
    has_secure_password
    def self.balanceToString(account)
      flbal = account.balance
      if flbal.nil?
        return "$0.00"
      end
      sbal = '%.2f' % flbal
      return "$#{sbal}"
      #dec = flbal%1
      #if (dec*100)%10 == 0 #and dec != 0
      #  return "$#{flbal}0"
      #else
      #  return "$#{flbal}"
      #end
    end
  
    def self.numeric?(amt)
      #flbal = account.balance
      Float(amt) != nil rescue false
    end
end
