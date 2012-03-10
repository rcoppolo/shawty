class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.integer :url_id
      t.string :http_referer
      t.integer :click_count

      t.timestamps
    end
  end
end
