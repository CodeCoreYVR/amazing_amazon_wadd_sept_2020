class User < ApplicationRecord
  has_secure_password

  has_many :products
  has_many :reviews

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  has_many :favourites, dependent: :destroy
  has_many :favourited_products, through: :favourites, source: :product

  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  has_many :news_articles, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  has_many :locations, dependent: :destroy
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX, unless: :from_omniauth?
  serialize :twitter_raw_data

  scope(:created_after, ->(date) { where("created_at < ?", "#{date}") })
  scope(:search, ->(query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%") })

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

  def self.find_from_omniauth(omniauth_data)
    User.where(provider: omniauth_data["provider"],
               uid: omniauth_data["uid"]).first
  end

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(uid: omniauth_data["uid"],
                provider: omniauth_data["provider"],
                first_name: full_name[0],
                last_name: full_name[1],
                oauth_token: omniauth_data["credentials"]["token"],
                oauth_secret: omniauth_data["credentials"]["secret"],
                oauth_raw_data: omniauth_data,
                password: SecureRandom.hex(16))
  end
end

# Generated this model using `rails g model user first_name:string last_name:string email:string`
