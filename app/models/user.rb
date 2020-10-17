class User < ApplicationRecord
  require 'csv'

  def self.import
    # file=File.open("#{Rails.root}/public/product_list.xlsx", "r:ISO-8859-1")

    csv_text = File.open("#{Rails.root}/public/product.csv", "r:ISO-8859-1")
    # sheet1 = csv_text.worksheet('Sheet1')
    csv = CSV.read(csv_text)
    csv.each_with_index do |row,index|


      if index.to_i > 0
        if row[2] = "Pillow"
          category = 1
        end
        if row[2] = "Zipper"
          category = 2
        end
        if row[2] = "Jar"
          category = 3
        end
        check_product = Product.where("product_name like '%#{row[0]}'")
        if !check_product.present?
          product = Product.create(:product_name=>row[0],:description=>'',:image=>'',:over_all_rating=>"null",:discount_available=>1,:total_quantity=>1,:vendor_detail_id =>1,:available=>1)
        end
        product_id = check_product.present? ? check_product[0].id : product.id
        if product_id.present?
          product_detail = ProductDetail.create(
                      :product_id => product_id,
                      :sku => (row[1].gsub(/[^0-9]/, '')).to_i,
                      :category => category,
                      :selling_rice => row[3].to_f,
                      :cost_price => row[3].to_f,
                      :gst => 5,
                      :discount_id => 1,
                      :discount_amount => 1,
                      :discount_percentage  => 1,
                      :quantity => 1,
                      :exchange_available => 1,
                      :replace => 1,
                      :status => 1,
                      :delivery_date => '2020-10-11',
          )
        end
      end
    end
  end
  # has_many :customers
end
