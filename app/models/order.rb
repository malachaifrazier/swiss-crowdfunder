class Order < ApplicationRecord
  belongs_to :goody,    optional: true
  belongs_to :donation, optional: true

  has_one :supporter, dependent: :destroy
  accepts_nested_attributes_for :supporter

  validates :payment_type, inclusion: { in: %w(stripe bank) }
  validates :agreement, presence: true
  validates :supporter, presence: true

  validate :goody, :are_goodies_left?#,   unless: Proc.new { |order| order.is_donation? == true }
  validate :goody, :is_campaign_active?#, unless: Proc.new { |order| order.is_donation? == true }

  # attr_accessor :is_donation
  #
  # def is_donation?
  #   self.is_donation
  # end

  def are_goodies_left?
    errors.add(:goody, 'No goodies left!') if goody.remaining_quantity == 0
  end

  def is_campaign_active?
    errors.add(:goody, 'Goody campaign is not active!') unless goody.campaign.is_active?
  end

end
