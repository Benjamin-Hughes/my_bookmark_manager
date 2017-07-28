require 'bcrypt'

class User
    include DataMapper::Resource

  property :id, Serial
  property :email, String

  # Stores the hash and the salt. String is only 50 characters, so we have to use Text
  property :password_digest, Text

  # Creates a password digest and saves it to the database
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
end
