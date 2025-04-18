# Used enumerable methods like group_by, sum, each, transform_values, max_by, and select

# SAMPLE INPUT

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


# METHODS



def order_total(order)

    order[:items].sum { |item| item[:unit_price] * item[:quantity] }
    
end


def total_revenue(orders)  

    orders.sum { |order| order_total(order) }
end

def top_customer(orders)
  customer_totals = orders.group_by { |order| order[:customer] }.transform_values { |customer_orders|customer_orders.sum { |order| order_total(order) } }
  customer_totals.max_by { |_customer, total| total }.first
end
# using transform here in order to transform the list of orders to total expenditure in the key value pair


def best_selling_item(orders)
  item_quantities = Hash.new(0)
  orders.each do |order|
    order[:items].each do |item|
      item_quantities[item[:name]] += item[:quantity]
    end
  end
  
  item_quantities.max_by { |_item, quantity| quantity }.first
end

def average_order_value(orders)
  return 0 if orders.empty?
  total_revenue(orders) / orders.size.to_f
end

def orders_above(orders, amount)
  orders.select { |order| order_total(order) >= amount }
end





puts "OUTPUT"
puts "-------"
puts "Total expenditure of the first order: $#{order_total(orders[0])}"

puts "\nTotal revenue: $#{total_revenue(orders)}"

puts "\nCustomer with the most expense: #{top_customer(orders)}"

puts "\nMost bought item: #{best_selling_item(orders)}"

puts "\nAverage order value: $#{average_order_value(orders)}"

puts "\nOrders above $20:"
orders_above(orders, 20).each do |order|
  puts "   #{order[:id]} - Customer: #{order[:customer]}, Total: $#{order_total(order)}"
end

