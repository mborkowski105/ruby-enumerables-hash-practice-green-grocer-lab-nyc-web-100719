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
          cart[item][:count] -= coupon[:num]
        elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
          cart["#{item} W/COUPON"][:count] += coupon[:num]
          cart[item][:count] -= coupon[:num]
        end
      end
    end
  
  return cart
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance] 
  end
  
  return cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count]}
  total > 100 ? total * 0.9 : total
end
