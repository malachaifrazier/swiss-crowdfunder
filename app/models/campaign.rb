class Campaign < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one_attached :campaign_image
  # has_one_attached :landing_page_image

  translates :title,
             :description,
             :description_html,
             :claim,
             :order_description,
             :order_description_html,
             :order_success,
             :order_success_html,
             :youtube_url

  default_scope { where(active: true) }

  has_many :goodies,    dependent: :destroy
  has_many :supporters, through: :goodies
  has_many :orders,     through: :goodies

  validates_presence_of :description, :title, :claim
  validates :goal, numericality: true, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_date, :is_end_before_start?
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  before_save :use_youtube_embedd_url
  before_save :convert_descriptions

  # after_create :create_donation_goodie

  def create_donation_goodie
    self.goody.create!(quantity: -1, price: 0)
  end

  def amount_raised
    goodies.inject(0) do |sum, g|
      sum += g.orders ? g.orders.sum(&:amount) : sum
    end
  end

  def is_active?
    start_date <= Date.today &&
    end_date >= Date.today
  end

  def days_left
    if end_date and end_date < DateTime.now.to_date
      'Ended ' << integer_end_date.abs.to_s.concat(' Days Ago')
      # ' and ended' << DateTime.now.advance(days: integer_end_date).concat(' Days Ago')
    elsif !end_date
      'Has not started yet'
    else
      integer_end_date.to_s.concat(' Days Left')
    end
  end

  def integer_end_date
    if end_date.present?
      (end_date - DateTime.now.to_date).to_i
    else
      0
    end
  end

  private

  # Regular Youtube URLs cannot be embedded into an iframe
  def use_youtube_embedd_url
    if youtube_url =~ /watch/
      youtube_url.sub!('watch?v=', 'embed/')
    end
  end

  def convert_descriptions
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new,
                                       fenced_code_blocks: true)
    self.description_html = renderer.render(description) if description
    self.order_description_html = renderer.render(order_description) if order_description
    self.order_success_html = renderer.render(order_success) if order_success
  end

  def is_end_before_start?
    if end_date and start_date
      errors.add(:end_date, 'End date has to be after the start date!') if end_date < start_date
    end
  end


end
