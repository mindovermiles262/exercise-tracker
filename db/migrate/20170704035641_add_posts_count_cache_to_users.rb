class AddPostsCountCacheToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :posts_count, :integer, default: 0

    # User.reset_column_information
    User.all.each do |u|
      u.update_attribute(:posts_count, u.posts.count)
    end
  end
end
