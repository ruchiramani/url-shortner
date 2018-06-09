class UrlStats < ActiveRecord::Migration
  def change
    create_table :url_stats do |t|
      t.string :url_id
      t.string :date
      t.integer :times_visited, default: 0, null: false
      t.timestamps null: false
    end
  end
end
