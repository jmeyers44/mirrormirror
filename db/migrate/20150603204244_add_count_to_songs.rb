class AddCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :play_count, :integer
  end
end
