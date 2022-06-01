# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map do |product|
      { product:, quantity: cart[product.id.to_s] }
    end
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map { |entry| entry[:product].price_cents * entry[:quantity] }.sum
  end
  helper_method :cart_subtotal_cents

  def enhanced_order
    @enhanced_order ||= LineItem.where(id: @order.line_item_ids).map do |line_item|
      { line_item:, image: Product.find(line_item[:id]).image, product: Product.find(line_item[:id]) }
    end
  end
  helper_method :enhanced_order

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
end
