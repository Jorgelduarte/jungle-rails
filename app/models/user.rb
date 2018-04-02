class User < ActiveRecord::Base
    has_secure_password
    
    validates_uniqueness_of :email, :case_sensitive => false

    validates :last_name, :first_name, :email, :password, presence: true
    
    validates :password, :length => {:within => 6..40}


    def self.authenticate_with_credentials email, password
        email.strip!
        email.downcase!
        if user = User.find_by(email: email).try(:authenticate, password)
          user
        else
          nil
        end
      end
end



