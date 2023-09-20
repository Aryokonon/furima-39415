class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :items, dependent: :destroy
  # has_many :orders, dependent: :destroy

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥ー々]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥ー々]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthdate, presence: true
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]+\z/, message: "must include at least one letter and one number" }

  def age
    ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end
end