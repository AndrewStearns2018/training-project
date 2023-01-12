class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :contributions, dependent: :destroy
  has_many :projects, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :country_of_residence, presence: true
  validates :nationality, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.date_of_birth = parse_birthday(auth.extra.raw_info.birthday)
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.parse_birthday(date)
    day = date[3..4]
    mounth = date[0..1]
    year = date[6..9]
    return Date.parse(day+"/"+mounth+"/"+year)
  end
end
