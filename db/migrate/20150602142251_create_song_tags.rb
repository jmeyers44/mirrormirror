class CreateSongTags < ActiveRecord::Migration
  def change
    create_table :song_tags do |t|
      t.belongs_to :song, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
