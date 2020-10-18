module BillHelper
  def get_product_sku(sku_id)
    res = {}
    get_product_detail = ProductDetail.where("id=#{sku_id.to_i}")
    return get_product_detail[0]
  end

  def get_product_detail(product_id)
    product_detail = Product.where("id=#{product_id.to_i}")
    return product_detail[0]

  end
end
