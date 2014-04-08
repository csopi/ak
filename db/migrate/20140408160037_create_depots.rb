class CreateDepots < ActiveRecord::Migration
  def change
    create_table :depots do |t|
      t.integer :user_id
      t.integer :item_id
      t.decimal :quantity, precision: 6, scale: 2
      t.date :delivery
      t.string :pass

      t.timestamps
    end
  end
end
