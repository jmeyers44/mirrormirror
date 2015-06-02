class CreateParseLibraries < ActiveRecord::Migration
  def change
    create_table :parse_libraries do |t|

      t.timestamps null: false
    end
  end
end
