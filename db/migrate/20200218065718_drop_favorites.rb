class DropFavorites < ActiveRecord::Migration[5.2]
  def change
    drop_table :favorites do |t|
      t.references :user, foregin_key: true
      t.references :post, foregin_key: true

      t.timestamps
    end
  end
end
