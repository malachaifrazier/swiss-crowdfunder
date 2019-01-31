class RemoveImageFromCampaigns < ActiveRecord::Migration[5.2]
  def change
    remove_column :campaigns, :image
  end
end
