require 'rails_helper'

describe 'admin dashboard', type: :feature do
  it 'is secure' do
    visit admin_root_path
    expect(page).to have_content 'Login'
  end

  it 'cannot be accessed without a user' do
    visit admin_root_path
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'nonsense'
    click_on 'Login'
    expect(page).to have_content 'Invalid Email or password.'
  end

  context 'Authenticated' do
    before :each do
      AdminUser.create! email: 'admin@example.com',
        password: '123123123',
        password_confirmation: '123123123'
      visit admin_root_path
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: '123123123'
      click_on 'Login'
    end

    it 'can be accessed with a user' do
      expect(page).to have_content 'Welcome to Active Admin'
    end

    it 'shows all Campaigns' do
      FactoryBot.create :campaign, title: 'Spec Campaign'

      click_on 'Campaigns'
      expect(page).to have_content 'Spec Campaign'
    end

    it 'shows all Goodies' do
      FactoryBot.create :goody, title: 'Spec Goodie'

      click_on 'Goodies'
      expect(page).to have_content 'Spec Goodie'
    end

    it 'shows all Orders' do
      goody = FactoryBot.create :goody
      supporter = FactoryBot.build :supporter
      Order.create! goody: goody, payment_type: 'stripe', agreement: true, supporter: supporter

      click_on 'Orders'
      expect(page).to have_content 'stripe'
    end

    context 'Campaigns' do
      it 'can update campaigns' do
        campaign = FactoryBot.create :campaign, title: 'Spec Campaign'

        click_on 'Campaigns'
        click_on 'Edit'
        fill_in 'campaign_title', with: 'some new title'
        click_on 'Update Campaign'
        expect(current_path).to eq(admin_campaign_path(campaign))
      end

      context 'Translatable Model attributes' do
        # NOTE: Translations are not important right now
        skip 'translates the models according to selected locale' do
          campaign = FactoryBot.create :campaign, title: 'Spec Campaign :DE'

          click_on 'EN'
          click_on 'Campaigns'
          click_on 'Edit'
          fill_in 'campaign_title', with: 'Spec Campaign :EN'
          fill_in 'campaign_claim', with: 'Spec Claim :EN'
          fill_in 'campaign_description', with: 'Spec Campaign Description :EN'
          click_on 'Update Campaign'

          campaign.reload

          # Campaign has been saved according to selected locale
          I18n.locale = :de
          expect(campaign.title).to eq('Spec Campaign :DE')
          I18n.locale = :en
          expect(campaign.title).to eq('Spec Campaign :EN')
          I18n.locale = I18n.default_locale

          # The translations are visible through AA
          click_on 'EN'
          expect(page).to have_content 'Spec Campaign :EN'
          expect(page).not_to have_content 'Spec Campaign :DE'
          click_on 'DE'
          expect(page).to_not have_content 'Spec Campaign :EN'
          expect(page).to have_content 'Spec Campaign :DE'
        end
      end

    end

    context 'Goodies' do
      it 'can update goodies' do
        goody = FactoryBot.create :goody

        click_on 'Goodies'
        click_on('Edit')
        fill_in 'goody_title', with: 'some new title'
        click_on 'Update Goody'
        expect(current_path).to eq(admin_goody_path(goody))
        expect(goody.reload.title).to eq('some new title')
      end

      it 'can create goodies for non-active campaigns' do
        FactoryBot.create :campaign,
          title: 'Non-active campaign',
          active: false

        expect(Campaign.all.count).to eq(0)
        expect(Campaign.unscoped.count).to eq(1)
        expect(Goody.count).to eq(0)

        click_on 'Goodies'
        click_on 'New Goody'
        select 'Non-active campaign', from: 'goody_campaign_id'
        fill_in 'goody_title', with: 'New goodie for non-active campaign'
        fill_in 'goody_description', with: 'Goody description'
        fill_in 'goody_price', with: '1000'
        fill_in 'goody_quantity', with: '1'
        click_on 'Create Goody'
        expect(current_path).to eq(admin_goody_path(Goody.first))
        expect(page).to have_content 'New goodie for non-active campaign'
        expect(Goody.count).to eq(1)
      end
    end

  end

end
