class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.string :title,     default: 'Donation'
      t.text :description, default: 'Donations are not associated with Goodies.'
      t.integer :quantity, default: -1
      t.references :campaign, foreign_key: true

      t.timestamps
    end

    add_column :orders, :donation_id, :bigint
  end
end
