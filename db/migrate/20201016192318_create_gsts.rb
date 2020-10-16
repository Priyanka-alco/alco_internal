class CreateGsts < ActiveRecord::Migration[5.0]
  def change
    create_table :gsts do |t|
      t.integer :gst_percentage
      t.integer :category
      t.boolean :status

      t.timestamps
    end
  end
end
