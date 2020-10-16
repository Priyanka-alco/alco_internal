class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  require 'sendgrid-ruby'
  include SendGrid
  # skip_before_filter :authenticate_request
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def product_selling
    # render layout: true
        @result = {}
        if params['phone_number'].present?
          phone_number = params['phone_number']
          customer_detail = Customer.where("phone='#{phone_number}'")
          if customer_detail
            @result['customer_detail'] = customer_detail
          end
        end
        product_id = params['product_id']
        start_time = Time.now
        product = Product.active_product
        res = []
        if product
          product.each do |val|
            product_detail = {}
            product_detail['product'] = val # product
            product_detail['vendor_detail'] = val.vendor_detail # vendor
            product_detail['discount_detail'] = val.discounts # discounts
            product_detail['product_detail'] = val.product_details # product_details
            res << product_detail
          end
          @result['status'] = 200
        else
          @result['status'] = 500
        end
        @result['product'] = res
  end
  def product_selling_detail
    order_id = params['order_id']
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    @result = []
    order = Order.where("id=#{order_id}")
    customer_id = order[0].cust_id
    customer_detail = Customer.where("id=#{customer_id}")
    @customer_detail = customer_detail
    # debugger
    @total_price = order[0].total
    get_order_detail.each_with_index do |val,index|
      res = {}
      res['order_detail']  = val
      # @result << {"total_price": order.total}
      # order_detail = Order.where("id=#{order_id}")
      product_id =   ( index==0) ? index+1 : index
      product_detail = Product.where("id=#{product_id}")
      res['product_name'] = product_detail[0].product_name
      @result << res
    end
  end
  def buy_product
    name = params['first_name']
    last_name = params['last_name']
    email_id = params['email']
    phone_no = params['phone_no']
    dob = params['dob']
    payment_type = params['payment_type']
    anniversary_date = params['anniversary_date']
    product_name = params['product_name']
    product_sku = params['sku']
    product_qty = params['qty']
    address = params['address']
    price = params['price']
    arr_price = price.values
    total_price = arr_price.map(&:to_f).reduce(:+)
    find_cust = Customer.where("phone=#{phone_no}")
    if !find_cust.present?
      create_customer = Customer.create(:first_name=>name, :last_name=>last_name,:email=>email_id,:phone=>phone_no,:address=>address)
    else
      create_customer = find_cust[0]
    end

    create_order = Order.create(:cust_id=>create_customer.id,
                                :seller_id=>1,
                                :total=>total_price,
                                :order_status => 0,
                                :payment_type=>payment_type,
                                :status=>payment_type)
    # puts "********#{create_customer.id}*********#{create_order.id}"
    product_name.each_with_index do |val,index|
      if(product_sku["#{index}"].present? && product_qty["#{index}"].present? && price["#{index}"].present?)

        OrderDetail.create(:product_id => product_name["#{index}"],
                           :sku_id=>product_sku["#{index}"],
                           :order_id=>create_order.id,
                           :quantity=>product_qty["#{index}"],
                           :selling_price=>price["#{index}"],
                           :status=>0)
      end
    end
    redirect_to  "/single_product_detail?order_id=#{create_order.id}&&view_detail=true"
  end

  # order status will be pending
  def update_order_status
    order_id = params['order_id']
    payment_type = params['payment_type']
    discounted_price = params['discounted_price']
    discount_id = params['discount_id']
    payment_status = payment_type
    get_order = Order.where("id=#{order_id}")
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    get_order[0].status = payment_status
    get_order[0].order_status = (payment_status == 2 ) ? 0 : 1
    get_order[0].discounted_price = discounted_price
    get_order[0].discount_id = discount_id
    get_order[0].save!
    get_order_detail.each do |order_detail|
      order_detail.status = 1
      order_detail.save!
    end
    render :json=> true
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  def single_product_detail
    order_id = params['order_id']
    get_order_detail = OrderDetail.where("order_id=#{order_id}")
    @result = []
    order = Order.where("id=#{order_id}")
    get_discount = Discount.where("   from_range <= #{order[0].total.to_i} AND to_range >=  #{order[0].total.to_i}")
    discount = get_discount.present? ? get_discount[0].discount : 30
    discount_id = get_discount.present? ? get_discount[0].id : 0
    get_discount = (order[0].total * discount)/100
    discounted_price = (order[0].total.to_i - get_discount.to_i)
    order[0].discounted_price = discounted_price
    customer_id = order[0].cust_id
    customer_detail = Customer.where("id=#{customer_id}")
    @customer_detail = customer_detail
    @discounted_price = discounted_price
    @discount = discount
    @discount_id = discount_id
    @total_price = order[0].total
    @payment_type = order[0].payment_type
    get_order_detail.each_with_index do |val,index|
      res = {}
      res['order_detail']  = val

      # @result << {"total_price": order.total}
      # order_detail = Order.where("id=#{order_id}")
      product_id =   val.product_id
      
      product = Product.where("id=#{product_id}")
      product_detail = ProductDetail.where("id=#{product_id}")
      res['product_name'] = product[0].product_name
      res['product_detail'] = product_detail
      @result << res
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def card_details

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :description, :image, :over_all_rating, :discount_available, :total_quantity, :available, :vendor_detail_id)
    end
end
