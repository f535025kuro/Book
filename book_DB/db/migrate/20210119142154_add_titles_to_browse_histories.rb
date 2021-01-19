class AddTitlesToBrowseHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :browse_histories, :post_title, :string
  end
end
