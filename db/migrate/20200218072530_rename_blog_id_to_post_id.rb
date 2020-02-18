class RenameBlogIdToPostId < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :blog_id, :post_id
  end
end
