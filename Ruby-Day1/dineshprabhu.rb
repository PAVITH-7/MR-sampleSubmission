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

def total_price(order)
total = 0
order[:items].each do |item|
    total += item[:unit_price] * item[:quantity]
end
total
end

def sum_total_price(order)
sum = 0
order.each do |order|
    sum += total_price(order)
end
sum
end

def top_customer(order)
customer_total = Hash.new(0)
order.each do |order|
    customer_total[order[:customer]] += total_price(order)
end
top_customer = customer_total.max_by { |customer, total| total }
top_customer[0]
end

def top_item(orders)
item_total = Hash.new(0)
orders.each do |order|
  order[:items].each do |item|
    item_total[item[:name]] += item[:quantity]
  end
end
top_item = item_total.max_by { |name, quantity| quantity }
top_item[0]
end


def average_order_value(order)
total = sum_total_price(order)
average = total / order.length.to_f
average
end

def above_amount(order, amount)
above = order.select { |order| total_price(order) > amount}
above
end

puts "Total Price of Order 1: #{total_price(orders[0])}"
puts "Sum of all Orders: #{sum_total_price(orders)}"
puts "Top Customer: #{top_customer(orders)}"
puts "Top Item: #{top_item(orders)}"
puts "Average Order Value: #{average_order_value(orders)}"
puts "Orders above 20: #{above_amount(orders, 20)}"