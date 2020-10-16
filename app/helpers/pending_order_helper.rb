module PendingOrderHelper
  def get_caller_detail(order_id)
    get_order_detail = Order.where("id=#{order_id}")
    get_caller_detail = User.where("id=#{get_order_detail[0].seller_id}")
    return get_caller_detail
  end
end
