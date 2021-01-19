class AddDetailsToRegistHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :regist_histories, :post_title, :string
    add_column :regist_histories, :post_author, :string
  end
end
