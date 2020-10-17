class AddFieldToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment_type, :integer
    add_column :orders, :order_status, :integer
    add_column :orders, :discounted_price, :decimal, precision: 10, scale: 2
    add_column :orders, :gst, :decimal, precision: 10, scale: 2
    add_column :orders, :discount, :integer

    add_column :customers, :dob, :date
    add_column :customers, :anniversary, :date
    add_column :order_details, :product_id, :integer
    add_column :users, :category, :integer
  end
end
