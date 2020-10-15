class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.integer :from_range
      t.integer :to_range
      t.float :discount
      t.boolean :status

      t.timestamps
    end
  end
end
