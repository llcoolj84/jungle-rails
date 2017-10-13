class User < ActiveRecord::Base
  
    has_secure_password
    has_many :reviews
    after_create :email_user
  
    validates_presence_of :first_name, :last_name, :email
    validates :email, uniqueness: true
  
    def email_user
      UserMailer.welcome_email(self).deliver
    end
  
  end
