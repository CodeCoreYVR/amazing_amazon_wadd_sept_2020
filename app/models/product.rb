class Product < ApplicationRecord
  # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
  DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
  # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide

  # Potential bug alert: :set_default_sale_price should always be called after :set_default_price otherwise you can end up with a sale price of nil
  before_validation :set_default_price, :set_default_sale_price
  before_save :capitalize_title

  validates(:title,
    presence: true,
    uniqueness: true,
    exclusion:
      { in: ['apple', 'microsoft', 'sony'],
        message: "%{value} is a reserved title. Please use a different title"
      }
  )
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
  validate :sale_price_less_than_price

  # scope(name, body, &block) is a method that will add a class method for retrieving records
  # https://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-scope
  # in ruby & rails docks &block means the method accepts a lambda.
  scope(:search, -> (query) { where("title ILIKE?", "%#{query}%") })

  # you can create a class method that does the same thing.

  def self.search_but_using_class_method(query)
    where("title ILIKE?", "%#{query}%")
  end

  def increment_hit_count
    new_hit_count = self.hit_count += 1
    update({ hit_count: new_hit_count })
  end
  private

  def set_default_price
    self.price ||= DEFAULT_PRICE
  end

  def capitalize_title
    self.title.capitalize!
  end

  def sale_price_less_than_price
    if self.sale_price > self.price
      errors.add(:sale_price, "sale_price: #{self.sale_price} must be lower than price: #{self.price}")
    end
  end

  def set_default_sale_price
    self.sale_price ||= self.price
  end
end
