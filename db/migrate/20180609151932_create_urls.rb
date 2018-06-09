class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original
      t.string :short
      t.string :domain
      t.integer :visited, default: 0, null: false
      t.timestamps null: false
    end
  end
end
