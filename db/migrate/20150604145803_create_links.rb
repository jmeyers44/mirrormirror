class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.belongs_to :song, index: true, foreign_key: true
      t.integer :accuracy_rating

      t.timestamps null: false
    end
  end
end
