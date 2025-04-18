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
	sum  = 0
	val = order[:items]
	val.each do |item|
		newval = item[:unit_price]*item[:quantity]
		sum+=newval
	end
	sum
end

def total_revenue(orders)
	total = 0
	orders.each do |order|
		total+=order_total(order)
	end
	total
end

def customer_spend(orders)
	customer_list = {}
	orders.each do |order|
		cname = order[:customer]
		camount = order_total(order)
		if customer_list.key?(cname)
			customer_list[cname]+=camount
		else
			customer_list[cname] = camount
		end
	end
	customer_list

end

def top_customer(orders)
	customer_list = customer_spend(orders)
	customer_name = ""
	customer_exp = 0
	customer_list.each do |key, value|
		if value > customer_exp
			customer_exp = value
			customer_name = key
		end
	end
	p customer_name

end

def best_selling_item(orders)
	top_selling = ""
	max = 0
	orders.each do |order|
		order[:items].each do |item|
			if item[:quantity]>max
				max = item[:quantity]
				top_selling = item[:name]
			end
		end
	end
	p top_selling
end

def average_order_value(orders)
	total = total_revenue(orders)
	order_size = orders.size
	average = total/order_size
	p average.to_f
end



def orders_above(orders, val)
	list = []
	orders.each do |order|
		check = order_total(order)
		if(check>=val)
			list.push(order)
		end
	end
	p list
end

# Total price of a single order 
p order_total(orders[0])

# Sum of all orders’ totals 
p total_revenue(orders)

# Name of the customer who spent the most in total 
top_customer(orders)

# Item name sold in the greatest total quantity across all orders 
best_selling_item(orders)

# Average order value (Float) 
average_order_value(orders)

# Array of orders (whole hashes) whose total >= amount 
orders_above(orders, 20)

