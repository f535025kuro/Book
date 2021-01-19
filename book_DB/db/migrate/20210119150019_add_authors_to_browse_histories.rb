class AddAuthorsToBrowseHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :browse_histories, :post_author, :string
  end
end
