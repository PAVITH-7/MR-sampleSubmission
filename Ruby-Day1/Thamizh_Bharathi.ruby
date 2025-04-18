def order_total(order)
    total_price=0.0
    order[:items].each do |item|
      total_price+=(item[:unit_price]*item[:quantity])
    end
    return total_price
end

def total_revenue(orders_list)
    total_revenue=0.0
    orders_list.each do |order|
      order_price=0
      order[:items].each do |item|
        curr_price=item[:unit_price]*item[:quantity]
        order_price+=curr_price
      end
      total_revenue+=order_price
    end
    return total_revenue
end

def top_customers(orders_list)
    customer_total=Hash.new(0)

    orders_list.each do |order|
      customer_name=order[:customer]
      total_price=order[:items].sum { |item| item[:unit_price] * item[:quantity]}
      customer_total[customer_name]+=total_price
    end
    max_customer, max_amount=customer_total.max_by {|name,total| total}
    
    return "#{max_customer} has spent #{max_amount}"
end

def best_selling_item(orders_list)
    item_count=Hash.new(0)

    orders_list.each do |order|
      order[:items].each do |item|
        item_name=item[:name]
        item_count[item_name]+=item[:quantity]
      end
    end
    max_item_name, max_item_count=item_count.max_by {|name,count| count}
    return "The best selling item is #{max_item_name} with count of #{max_item_count}"
end

def avg_order_value(orders_list)
    total_price=0.0
    orders_list.each do |order|
      order_price=order[:items].sum {|item| item[:unit_price]*item[:quantity]}
      total_price+=order_price
    end
      return "The avg value of orders is #{total_price/(orders_list.length)}"
end

def orders_above(orders_list,limit_amount)
  threshold_crossed_orders=[]
  orders_list.each do |order|
    total_price=0.0
    
    total_price=order[:items].sum {|item| item[:unit_price]*item[:quantity]}
    if total_price > limit_amount
      threshold_crossed_orders.push(order)
    end
  end
    return threshold_crossed_orders
end

orders = [
  {
    id: 1,
    customer: "Alice",
    items: [
      { name: "Book",     unit_price: 12.99, quantity: 2 },
      { name: "Pen",      unit_price:  1.49, quantity: 5 }
    ]
  },
  {
    id: 2,
    customer: "Bob",
    items: [
      { name: "Notebook", unit_price:  5.99, quantity: 3 }
    ]
  },
  {
    id: 3,
    customer: "Alice",
    items: [
      { name: "Pencil",   unit_price:  0.99, quantity: 10 }
    ]
  },
  {
    id: 4,
    customer: "Charlie",
    items: [
      { name: "Book",     unit_price: 12.99, quantity: 1 },
      { name: "Notebook", unit_price:  5.99, quantity: 2 }
    ]
  }
]

puts "-----Each order with its total value----------"
for i in 0..(orders.length-1)
    puts order_total(orders[i])
end

puts "-------total revenue of all the orders--------"
 puts total_revenue(orders)
puts "-------Top customer with max orders--------"
 puts top_customers(orders)
puts "-------Best selling item--------"
 puts best_selling_item(orders) 
puts "-------Avg order value--------"
 puts avg_order_value(orders)
puts "-------Orders above a limit--------"
 puts orders_above(orders,20)