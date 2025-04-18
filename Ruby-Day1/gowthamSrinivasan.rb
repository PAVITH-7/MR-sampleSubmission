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


def order_total(order)
  order[:items].map { |item| item[:unit_price] * item[:quantity] }.sum
end


def total_revenue(orders)
  orders.map { |order| order_total(order) }.sum
end


def top_customer(orders)
  spending = Hash.new(0)

  orders.each do |order|
    spending[order[:customer]] += order_total(order)
  end

  spending.max_by { |_, total| total }[0]
end


def best_selling_item(orders)
  sales = Hash.new(0)

  orders.each do |order|
    order[:items].each do |item|
      sales[item[:name]] += item[:quantity]
    end
  end

  sales.max_by { |_, quantity| quantity }[0]
end


def average_order_value(orders)
  total_revenue(orders) / orders.size.to_f
end


def orders_above(orders, amount)
  orders.select { |order| order_total(order) >= amount }
end


puts "order_total(orders[0]) = #{order_total(orders[0])}"           
puts "total_revenue = #{total_revenue(orders)}"                         
puts "top_customer = #{top_customer(orders)}"                          
puts "best_selling_item = #{best_selling_item(orders)}"              
puts "average_order_value = #{average_order_value(orders)}"        
puts "orders_above(20):"
puts orders_above(orders, 20).map { |o| o[:id] }.inspect                
