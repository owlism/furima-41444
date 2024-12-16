class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :ship_fee
  belongs_to :ship_region
  belongs_to :ship_wait

  validates :category_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :ship_fee_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :ship_region_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :ship_wait_id, numericality: { other_than: 0 , message: "can't be blank"}

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 ,only_integer:true}

  validates :name, :description, :price, :image, presence: true
end
