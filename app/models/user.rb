class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :protect_last_admin
  before_update :protect_last_admin

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6}

  has_secure_password

  has_many :tasks, dependent: :destroy
  has_many :tasks, dependent: :destroy

  private
  def protect_last_admin
    throw(:abort) if User.where(admin: true).count == 1 
  end
end
