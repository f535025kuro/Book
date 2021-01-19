class AddIdsToBrowseHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :browse_histories, :user_id, :integer
    add_column :browse_histories, :post_id, :integer
  end
end
