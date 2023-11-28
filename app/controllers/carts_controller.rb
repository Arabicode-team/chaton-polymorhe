class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def add
    @cart = current_user.cart || current_user.create_cart
    photo = Photo.find(params[:photo_id])
    @cart.line_items.create(photo: photo, quantity: 1, price: photo.price)
    redirect_to cart_path(@cart), notice: 'Photo added to cart.'
  end

  def remove
    line_item = current_user.cart.line_items.find(params[:line_item_id])
    line_item.destroy
    redirect_to cart_path, notice: 'Item was removed from your cart.'
  end
  # before_action :set_cart, only: %i[ show edit update destroy ]

  # # GET /carts or /carts.json
  # def index
  #   @carts = Cart.all
  # end

  # # GET /carts/1 or /carts/1.json
  # def show
  # end

  # # GET /carts/new
  # def new
  #   @cart = Cart.new
  # end

  # # GET /carts/1/edit
  # def edit
  # end

  # # POST /carts or /carts.json
  # def create
  #   @cart = Cart.new(cart_params)

  #   respond_to do |format|
  #     if @cart.save
  #       format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
  #       format.json { render :show, status: :created, location: @cart }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /carts/1 or /carts/1.json
  # def update
  #   respond_to do |format|
  #     if @cart.update(cart_params)
  #       format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
  #       format.json { render :show, status: :ok, location: @cart }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /carts/1 or /carts/1.json
  # def destroy
  #   @cart.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_cart
  #     @cart = Cart.find(params[:id])
  #   end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
