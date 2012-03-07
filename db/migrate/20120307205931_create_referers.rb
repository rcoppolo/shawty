class CreateReferers < ActiveRecord::Migration
  def change
    create_table :referers do |t|
      t.integer :url_id
      t.string :http_referer

      t.timestamps
    end
    add_index :referers, :url_id
  end
end
