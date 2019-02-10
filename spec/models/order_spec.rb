require 'rails_helper'

RSpec.describe Order, type: :model do
  context "when a Donation is placed" do
    describe "it can be created" do
      it "and can be accepted" do
        campaign = FactoryBot.create :campaign
        donation = FactoryBot.create :donation, campaign: campaign
        order = FactoryBot.build :order, donation: donation
        expect(order).to be_valid
      end
    end
  end

  describe 'security' do
    it 'is not possible to buy goodies when the campaign does not run' do
      campaign = FactoryBot.create :campaign,
        start_date: 100.days.from_now,
        end_date: 200.days.from_now
      goody = FactoryBot.create :goody, campaign: campaign
      order = FactoryBot.build :order, goody: goody
      expect(order).to_not be_valid
      expect(order.errors.first).to eq([:goody, 'Goody campaign is not active!'])
    end

    it 'is possible to buy goodies when the campain starts today' do
      campaign = FactoryBot.create :campaign, start_date: Time.now
      goody = FactoryBot.create :goody, campaign: campaign
      order = FactoryBot.build :order, goody: goody
      expect(order).to be_valid
    end

    it 'is possible to buy as long as there are goodies left' do
      goody = FactoryBot.create :goody, quantity: 3
      # Buying the first three works
      3.times do
        order = FactoryBot.build :order, goody: goody
        expect(order).to be_valid
        order.save!
      end

      # When there are no more goodies left
      order = FactoryBot.build :order, goody: goody
      expect(order).to_not be_valid
      expect(order.errors.first).to eq([:goody, 'No goodies left!'])
    end

  end
end
