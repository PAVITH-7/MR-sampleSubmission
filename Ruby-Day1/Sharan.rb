# My take on the problem statement, I have built a menu like system to take in dynamic and different choices and implemented it using simple case blocks. 
# I have used enumerables for all the methods as well.
orders = [
  {
    id: 1,
    customer: "Alice",
    items: [
      { name: "Book",     price: 12.99, quantity: 2 },
      { name: "Pen",      price:  1.49, quantity: 5 }
    ]
  },
  {
    id: 2,
    customer: "Bob",
    items: [
      { name: "Notebook", price:  5.99, quantity: 3 }
    ]
  },
  {
    id: 3,
    customer: "Alice",
    items: [
      { name: "Pencil",   price:  0.99, quantity: 10 }
    ]
  },
  {
    id: 4,
    customer: "Charlie",
    items: [
      { name: "Book",     price: 12.99, quantity: 1 },
      { name: "Notebook", price:  5.99, quantity: 2 }
    ]
  }
]

def totalpricesingle(orders,target_id)
  
  result = orders.find{|item| item[:id]==target_id}
  total= result[:items].map{|item| item[:price]* item[:quantity]}.sum
  puts "Total order amount for id:#{target_id} is #{total}"
  puts "................"
end

def totalpriceall(orders)
  result = orders.map do |order|
    order[:items].map{|item| item[:price]*item[:quantity]}.sum
  end.sum
  puts "Total price of all orders amount to #{result}"
  puts "................"
end

def topcustomer(orders)
  topcustomer= orders.max_by do |order|
    order[:items].map{|item| item[:price] * item[:quantity]}.sum
  end[:customer]
  puts "The Customer with the most Bought items is #{topcustomer}"
  puts "................"

end

def topitem(orders)
  allitems= orders.flat_map{|order| order[:items] }
  totalitems=allitems.group_by{|item| item[:name]}.transform_values do |items|
    items.sum{|item| item[:quantity]}
  end
  maxitem=totalitems.max_by{|item,qty| qty}
  puts "The item that is most bought is #{maxitem[0]}"
  puts "................"

end

def avgvalue(orders)
  result = orders.map do |order|
    order[:items].map{|item| item[:price]*item[:quantity]}.sum
  end.sum
  puts "The average order value is #{result/orders.size}"
  puts "................"
end

def amountorder(orders,amount)
  
  result =orders.select do |order|
    total= order[:items].sum{|item| item[:price]*item[:quantity]}
    total > amount
  end
  puts "The orders with total price more than #{amount} is: "
  puts result.inspect
  puts "................"
end
def reporting_tool(orders)
  loop do
    puts "Mini Reporting Tool"
    puts "1. Total price of an order"
    puts "2. Sum of all order totals"
    puts "3. Most spent Customer"
    puts "4. Most bought item"
    puts "5. Average order value"
    puts "6. Orders over amount"
    puts "7. Exit"
    print "Enter Choice: "
    choice = gets.chomp.to_i
    
    case choice
    when 1
      print "Enter id: "
      target_id=gets.chomp.to_i
      totalpricesingle(orders,target_id)
    when 2
      totalpriceall(orders)
    when 3
      topcustomer(orders)
    when 4
      topitem(orders)
    when 5
      avgvalue(orders)
    when 6
      print "Enter a min amount: "
      amount= gets.chomp.to_i
      amountorder(orders,amount)
    when 7
      puts "Exiting...."
      break
    else
      puts "Not a valid choice"
    end
  end
end
reporting_tool(orders)
