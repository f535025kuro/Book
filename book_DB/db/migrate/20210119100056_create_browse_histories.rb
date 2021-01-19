class CreateBrowseHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :browse_histories do |t|

      t.timestamps
    end
  end
end
