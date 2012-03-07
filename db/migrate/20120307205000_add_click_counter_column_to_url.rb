class AddClickCounterColumnToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :click_counter, :integer

  end
end
