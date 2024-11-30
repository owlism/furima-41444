class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
         validates_format_of :password, with: VALID_PASSWORD_REGEX
       
         ZENKAKU_INPUT = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
         validates :family_name, :first_name, format: { with: ZENKAKU_INPUT }
       
         ZENKAKU_KANA_INPUT = /\A([ァ-ン]|ー)+\z/.freeze
         validates :family_kana, :first_kana, format: { with: ZENKAKU_KANA_INPUT }

  with_options presence: true do
   validates :nickname
   validates :birth_date
  end
  has_many :items
end