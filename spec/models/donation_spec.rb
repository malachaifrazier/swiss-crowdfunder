require 'rails_helper'

RSpec.describe Donation, type: :model do
  # subject { Donation }
  let(:campaign)  { FactoryBot.create(:campaign) }
  let(:donation) { FactoryBot.create(:donation, campaign: campaign) }

  describe 'validation of attrs' do
    subject { Donation.new }
    it { should validate_presence_of(:campaign_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:quantity) }
  end

  # belongs_to :campaign, -> { unscope(where: 'active') }
  # has_many :orders
  # has_many :supporters, through: :orders
  #
  # validates :quantity, numericality: true, presence: true
  # validates_presence_of :title, :description, :campaign_id

  describe 'factory' do
    it 'have_a_valid_factory' do
      expect(donation).to be_valid
    end
  end

  describe 'reflections' do
    it 'are valid for Campaign' do
      expect(donation).to belong_to(:campaign)
    end

    it 'are valid for Supporters' do
      expect(donation).to have_many(:supporters).through(:orders)
    end

    it 'are valid for Orders' do
      expect(donation).to have_many(:orders)
    end
  end

  # describe 'initially quantity' do
  #   it 'is defaulted' do
  #     donation = FactoryBot.create :donation, quantity: 100
  #     expect(donation.orders_count).to eq(0)
  #     expect(donation.remaining_quantity).to eq(100)
  #   end
  #
  #   it 'remaining quantity is less if there are orders' do
  #     donation = FactoryBot.create :donation, quantity: 100
  #     3.times { FactoryBot.create :order, donation: donation }
  #
  #     expect(donation.remaining_quantity).to eq(97)
  #   end
  # end
end
