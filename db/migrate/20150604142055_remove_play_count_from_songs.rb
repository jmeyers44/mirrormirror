class RemovePlayCountFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :play_count, :integer
  end
end
