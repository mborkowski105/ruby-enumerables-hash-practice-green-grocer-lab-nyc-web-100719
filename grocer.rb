def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |e|
    e_name = e.keys[0]
    if cart_hash.has_key?(e_name)
      cart_hash[e_name][:count] +=1
    else
      cart_hash[e_name] = {
        count: 1,
        price: e[e_name][:price],
        clearance: e[e_name][:clearance]
      }
    end
  end
  
  return cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
      if cart.has_key?(item)
        if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"][:count] += coupon[:num]
        end
        cart[item][:count] -= coupon[:num]
      end
    end
  
  return cart
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price]
  end
  
  return cart
end

def checkout(cart, coupons)
  # code here
end
