class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :title, null:false
      t.string :author, null:false
      t.text :description
      t.string :publisher

      t.timestamps
    end
  end
end
