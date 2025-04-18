#sample data input given
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

#tot of any 1 order of customer

puts ("Give me the order number")
num=gets.chomp
def total(order)
    tot=0;
    
order[:items].each do |item|
    
    tot+=item[:unit_price]*item[:quantity];
   
end
return tot
end
  
puts  total(orders[num.to_i])


#sum of all orders

def sum(orders)
  return orders.sum { |order| total(order)}
  
end

puts sum(orders)


#finding max to get the most spent customer

def max(orders)
  total_spent=Hash.new(0)
  orders.each do |order|
    cus_name=order[:customer]
    total_spent[cus_name]+=total(order)
    
  end
  total_spent.max_by {|cus_name,amount| amount}[0]
end

puts max(orders)

#find most sold item

def most_sold(orders)
  sold_quan=Hash.new(0)
orders.each do |order|
  order[:items].each do |item|
    item_name=item[:name]
    sold_quan[item_name]+=item[:quantity]

  end

end
return sold_quan.max_by {|name,quantity| quantity}[0]
  
end

puts most_sold(orders)


#find avg val

def avg(orders)
  return 0 if orders.empty?
  
    avg=sum(orders)/orders.length.to_f
  
  return avg
  
end

puts avg(orders)



#find orders that have  amount to be paid  >=  the cash that customer has

def enough_cash(orders,amount)
    selected_orders=orders.select { |order| 
      total(order) >= amount }
      final_tot_amt=selected_orders.sum {|order| total(order)}
      return final_tot_amt,selected_orders
end
puts("Enter the amount you have")
amt=gets.chomp
amt_to_be_paid,item_details= enough_cash(orders,amt.to_i)
puts amt_to_be_paid
puts item_details




