class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :item_id
      t.integer :project_id
      t.decimal :quantity, precision: 6, scale: 2

      t.timestamps
    end
  end
end
