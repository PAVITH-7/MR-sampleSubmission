#Sample Input
sample_order = [
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

#Method 1 - Calculate Total Order Amount
def order_total(order)
    order_sum = 0
    for items in order[:items]
        order_sum+= items[:unit_price] * items[:quantity]
    end
    return order_sum
end

#Method 2 - Calculate Total Revenue
def total_revenue(orders)
    revenue = 0
    orders.each do |order|
        revenue += order_total(order)
    end
    return revenue
end

#Method 3 - Find Top Customer
def top_customer(orders)
    customers=Hash.new
    customer = ""
    max_spent = 0
    
    orders.each do |order|
        customer_spent = order_total(order)
        if customers.has_key?(order[:customer])
            customers[order[:customer]] += customer_spent
        else
            customers[order[:customer]] = customer_spent
        end
    end
    

    customers.each { |customer_name,customer_spent|
        if "#{customer_spent}".to_f >= max_spent
            customer = "#{customer_name}"
            max_spent = "#{customer_spent}".to_f
        end
    }
    
    return customer , max_spent.to_s
end

#Method 4 - Find Frequently Bought Item
def best_selling_item(orders)
    items=Hash.new
    max_item_name = ""
    max_quantity = 0
    
    orders.each do |single_order|
        single_order[:items].each do |single_item|
            if items.has_key?(single_item[:name])
                items[single_item[:name]] += single_item[:quantity]
            else
                items[single_item[:name]] = single_item[:quantity]
            end
        end
    end
    
    items.each { |item_name,item_qty|
        if "#{item_qty}".to_f >= max_quantity
            max_item_name = "#{item_name}"
            max_quantity = "#{item_qty}".to_i
        end
    }
    
    return max_item_name, max_quantity.to_s
end

#Method 5 - Find Average Order Value
def average_order_value(orders)
    total_rev=total_revenue(orders)/orders.length()
    return total_rev.to_f
end

#Method 6 - Find Orders above a Particular Value
def orders_above(orders, limit)
    order_array=Array.new
    
    orders.each do |order|
        sum=order_total(order)
        if sum >= limit
            order_array.push(order)
        end
    end
    return order_array
end

#MENU
print "1. Calculate Total Price of a single order\n2. Calculate sum of all orders\n3. Find customer with maximum expenditure\n4. Item that is most frequently bought\n5. Average value of an order\n6. Orders valued above a specified range\nChoose your option : "
option = gets.chomp().to_i
case option
    when 1
        print "Enter Order Number : "
        order_num = gets.chomp().to_i
        if order_num <= sample_order.length()
            puts "\nTotal Price of Order " + order_num.to_s + " is : " + order_total(sample_order[order_num-1]).to_s
        else
            puts "\nInvalid Order Number. Please Try Again!"
        end
    when 2
        puts "\nTotal sum of all orders is : " + total_revenue(sample_order).to_s
    when 3
        name,amount = top_customer(sample_order)
        puts
        puts name + ", by spending Rs." + amount + ", is the customer with maximum expenditure."
        
    when 4
        item,qty = best_selling_item(sample_order)
        puts
        puts item.to_s + " is the most bought item, being sold " + qty.to_s + " times."
    when 5
        puts "\nThe average order value is : "+average_order_value(sample_order).to_s
    when 6
        print "Enter Minimum Order Value Limit : "
        min_limit = gets.chomp().to_i
        puts
        limit_orders = orders_above(sample_order,min_limit)
        if limit_orders.length() >=1 
            puts "Orders that match your selection :"
            for select_orders in limit_orders
                puts "--------------------------------------------"
                puts "Order Id : " + select_orders[:id].to_s
                puts "Order Amount : " + order_total(select_orders).to_s
                puts "Order :"
                puts select_orders
                puts "--------------------------------------------"
                puts
            end
        else
            print "\nThere are no orders that match your selection."
        end
    else
        print "\nInvalid option.Try Again!!"
end