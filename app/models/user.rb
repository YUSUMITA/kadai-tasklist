class User < ApplicationRecord
    has_secure_password validations: true
    
    before_save { self.email.downcase! }
    
    validates :name,
        presence: true,
        length: {maximum: 50}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
        presence: true,
        length: { maximum: 255},
        format: { with: VALID_EMAIL_REGEX, allow_blank: true},
        uniqueness: { case_sensitive: false }
    
    has_many :tasks
    
end
