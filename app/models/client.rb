class Client < ActiveRecord::Base

  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation

  

  before_save { |client| client.email = client.email.downcase }



# valida a presença de um nome
  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
  					uniqueness: { case_sensitive: false }      

  validates :password, length: {minimum: 6}
  validates :password_confirmation,  presence: true
end
