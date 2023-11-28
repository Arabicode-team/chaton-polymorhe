class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @cart = current_user.cart
    @total_price = @cart.line_items.sum('price * quantity')
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def charge
    amount_in_cents = (params[:amount].to_f * 100).to_i
    # Создание платежа через Stripe
    charge = Stripe::Charge.create({
      amount: amount_in_cents, # Убедитесь, что это в центах!
      currency: 'usd',
      description: 'Order description',
      source: params[:stripeToken],
    })

    # Создание заказа после успешного платежа
    create_order(params[:amount])

    redirect_to root_path, notice: 'Thank you for your order!'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_order_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def create_order(amount)
      order = current_user.orders.create(total_price: amount)
    end
    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :total_price, :status)
    end
end
