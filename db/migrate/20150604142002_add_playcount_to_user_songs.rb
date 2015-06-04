class AddPlaycountToUserSongs < ActiveRecord::Migration
  def change
    add_column :user_songs, :play_count, :integer
  end
end
