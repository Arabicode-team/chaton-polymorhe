class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_cart, :welcome_send

  private
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  def create_cart
    Cart.create(user: self)
  end
end
