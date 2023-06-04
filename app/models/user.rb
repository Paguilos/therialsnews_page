class User < ApplicationRecord
  # attr_accessor :role, :username
  enum :role, [:normal_user, :author, :admin]
  
  # validates :username, presence: true
  # validates :role, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :notes

  
end
