class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|
      t.references :itemable, polymorphic: true, null: false
      t.references :photo, null: false, index: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
