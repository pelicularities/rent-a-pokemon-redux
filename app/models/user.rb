class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  has_many :pokemons, dependent: :destroy
  has_many :rentals
  has_many :reviews, through: :rentals
 
  def email_required?
    false
  end
  
  def email_changed?
    false
  end
end
