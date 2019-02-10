class Donation < ApplicationRecord
  belongs_to :campaign, -> { unscope(where: 'active') }
  has_many :orders
  has_many :supporters, through: :orders

  validates :quantity, numericality: true, presence: true
  validates_presence_of :title, :description, :campaign_id

  def orders_count
    orders.count
  end

  def remaining_quantity
    if quantity != -1
      quantity - orders_count
    else
      '∞'
    end
  end

end
