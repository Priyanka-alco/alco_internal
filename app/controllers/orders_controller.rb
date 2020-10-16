class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def pending_order
     @res = {}
    get_order_detail = Order.where("order_status=1").order("id DESC")
    @res['order_details'] = get_order_detail
  end

  def completed_order
    @res = {}
    get_order_detail = Order.where("order_status=2").order("id DESC")
    @res['order_details'] = get_order_detail
  end

  def bill
    order_id = params['order_id']
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    @result = []
    order = Order.where("id=#{order_id}")
    customer_id = order[0].cust_id
    customer_detail = Customer.where("id=#{customer_id}")
    @customer_detail = customer_detail
    @order = order[0]
    @discount =  order[0].total.to_i - order[0].discounted_price.to_i
    get_order_detail.each_with_index do |val,index|
      res = {}
      res['order_detail']  = val
      # @result << {"total_price": order.total}
      # order_detail = Order.where("id=#{order_id}")
      product_id =   ( index==0) ? index+1 : index
      product = Product.where("id=#{product_id}")
      product_detail = ProductDetail.where("id=#{product_id}")
      res['product_name'] = product[0].product_name
      res['sku_detail'] = product_detail[0].sku
      @result << res
    end
  end

  def payment
    card_number = params['card_number']
    expiry_date = params['expiry_date']
    cvc = params['cvc']
    card_holder_name = params['card_holder_name']
    payment_method = params['payment_method']
    cust_id = params['cust_id']
    order_id = params['order_id']
    if payment_method == "1"
      # (pay via card)
      create_card = CardDetail.create(:card_number => card_number,
                        :expiry_date => expiry_date,
                        :cvc_code => cvc,
                        :cardholder_name => card_holder_name,
                        :cust_id => cust_id)

    else
      # (pay via paytm)
    end
    order_id = params['order_id']
    order_status = 1
    get_order = Order.where("id=#{order_id}")
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    get_order[0].order_status = order_status
    get_order[0].save!
    get_order_detail.each do |order_detail|
      order_detail.status = order_status
      order_detail.save!
    end
    redirect_to "/payment_acknowledgement?cust_id=#{cust_id}&&order_id=#{order_id}"
  end

  def payment_acknowledgement
    @res = {}
    cust_id = params['cust_id']
    order_id = params['order_id']
    customer_detail = Customer.where("id='#{cust_id}'")
    # order_detail = Order.where("id=#{order_id}")
    @res['customer_detail'] = customer_detail
     @res['order_id'] = order_id
  end

  def get_address
    address = params['address']
    res = {}
    arr = []
    get_customer = Customer.select("DISTINCT  phone,address").where("address like '%#{address}%'")
    get_customer.each do |data|
      arr << data
    end
    res['address'] = arr
    puts "*****************#{get_customer}"
    render :json=>res
  end

  def complete_order
    order_id = params['order_id']

    get_order_detail = Order.where("id=#{order_id}").order("id DESC")
    get_order_detail[0].order_status = 2
    get_order_detail[0].save!
  end

  def customer_payment_page
    order_id = params['order_id']
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    @result = []
    order = Order.where("id=#{order_id}")
    customer_id = order[0].cust_id
    customer_detail = Customer.where("id=#{customer_id}")
    @customer_detail = customer_detail
    # debugger
    @order = order
    @discount = order[0].total.to_i - order[0].discounted_price.to_i
    @total_price = order[0].total
    get_order_detail.each_with_index do |val,index|
      res = {}
      res['order_detail']  = val

      product_id =   ( index==0) ? index+1 : index
      product = Product.where("id=#{product_id}")
      product_detail = ProductDetail.where("product_id=#{product_id}")
      res['product_name'] = product[0].product_name
      res['sku_detail'] = product_detail[0].sku
      @result << res
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  def next_order
    order_id = params['order_id']
    order_status = params['order_status']

    orders = Order.where("order_status=#{order_status} and id NOT IN (?) and id < #{order_id.to_i}",[order_id] ).order("id DESC").first();
    redirect_to "/operation_order_detail?order_id=#{orders.id}"
  end

  def get_caller_history
    caller_id = params['caller_id']
    @caller_detail = User.where("id=#{caller_id}")
    orders = Order.where("seller_id=#{@caller_detail[0].id}")
    @res = []
    orders.each do |order|
      result = {}
      get_order_detail = OrderDetail.where("order_id=#{order.id}")
      result['order_detail'] = get_order_detail
      result['order'] = order
      @res << result
    end
  end

  def all_order
    @res = {}
    get_order_detail = Order.all().order("id DESC")
    @res['order_details'] = get_order_detail
  end

  def operation_order_detail
    order_id = params['order_id']
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    @result = []
    order = Order.where("id=#{order_id}")
    order_status = order[0].order_status
    last_order =  Order.where("order_status=#{order_status} and id NOT IN (?) and id < #{order_id.to_i}",[order_id] ).order("id DESC").first();
    @next_order = false
    if last_order.present? && last_order.id.to_i != order_id.to_i
      @next_order = true
    end
    customer_id = order[0].cust_id
    customer_detail = Customer.where("id=#{customer_id}")
    @customer_detail = customer_detail
    discount_id = order[0].discount_id.present? ? order[0].discount_id : 20
    # debugger
    get_discount_detail = Discount.where("id=#{discount_id}")
    @discount_detail = get_discount_detail
    @order = order[0]
    @discount =  order[0].total.to_i - order[0].discounted_price.to_i
    get_order_detail.each_with_index do |val,index|
      res = {}
      res['order_detail']  = val
      # @result << {"total_price": order.total}
      # order_detail = Order.where("id=#{order_id}")
      product_id =   ( index==0) ? index+1 : index
      product = Product.where("id=#{product_id}")
      product_detail = ProductDetail.where("product_id=#{product_id}")
      res['product_name'] = product[0].product_name
      res['sku_detail'] = product_detail[0].sku
      @result << res
    end

  end

  # GET /orders/1/edit
  def edit
  end

  def order
    seller = session[:admin] != true ? User.where("email='#{session[:email_id]}' and status =1") :  User.where("status =1")
    order_detail = Order.where("seller_id=#{seller[0].id}").order( 'id DESC' )
    @res = []
    order_detail.each do |val|
      result = {}
      result['order_detail'] = val
      customer_detail = Customer.where("id=#{val.cust_id}")
      result['customer_detail'] = customer_detail
      @res << result
    end

  end
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def customer_discount
    total_price = params['total_price']
    get_discount = Discount.where("from_range <= #{total_price.to_i} AND to_range >=  #{total_price.to_i}")
    discount = get_discount.present? ? get_discount[0].discount : 20
    discount_id = get_discount.present? ? get_discount[0].id : 0
    get_discount = (total_price.to_i * discount.to_i)/100
    discounted_price = (total_price.to_i - get_discount.to_i)
    res = {}
    res['discounted_price'] = discounted_price
    res['discount'] = "#{discount}%"
    render :json=>res
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:cust_id, :total, :discount_id, :seller_id, :status)
    end
end
