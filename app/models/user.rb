class User < ApplicationRecord
    before_save { self.email = email.downcase}
    has_many :articles, dependent: :destroy #has_many: crea una relacion foranea con articles,dependent crea una eliminacion en cascada.
    validates :username, presence: true,
                         uniqueness: {case_sensitive: false}, 
                         length: {minimum:3, maximum:25}
    VALIT_EMAIL_EXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i                       
    validates :email, presence: true,
                      uniqueness: {case_sensitive: false},
                      length: {maximum:105},
                      format:{with: VALIT_EMAIL_EXP}
    validates :email, presence: true,
              length: {minimum:8}
    has_secure_password
end