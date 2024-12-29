class BuyForm
include ActiveModel::Model
attr_accessor :user_id, :item_id, :post_number, :ship_region_id, :city, :house_number, :building_name, :phone_number, :token
with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'must be 10 or 11 digits long' }
    validates :token
  end
  validates :ship_region_id, numericality: { other_than: 0, message: "can't be blank" }
  
  def save
    buy = Buy.create(user_id:, item_id:)

    Address.create(
      post_number: post_number,
      ship_region_id: ship_region_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      buy_id: buy.id
    )
  end
end