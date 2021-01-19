class AddIdsToRegistHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :regist_histories, :user_id, :integer
    add_column :regist_histories, :post_id, :integer
  end
end
