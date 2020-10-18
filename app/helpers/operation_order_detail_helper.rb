module OperationOrderDetailHelper
  def get_product_sku(sku_id)
    get_product_detail = ProductDetail.where("id=#{sku_id.to_i}")
    return get_product_detail[0]
  end
end
