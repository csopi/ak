class CreateCurrents < ActiveRecord::Migration
  def change
    create_table :currents do |t|
      t.integer :item_id
      t.integer :project_id
      t.decimal :quantity
      t.string :pass
      t.date :delivery

      t.timestamps
    end
  end
end
