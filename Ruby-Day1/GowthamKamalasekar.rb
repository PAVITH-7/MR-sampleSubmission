class Order
    attr_accessor :id, 
                  :customer, 
                  :items

    def initialize(id, customer, items)
        @id = id
        @customer = customer
        @items = items
    end

    def order_total()
        total = 0.0
        for item in items
            total += item["unit_price"] * item["quantity"]
        end
        return total
    end
end

def total_revenue(orders)
    total_revenue = 0.0
    for order in orders
        total_revenue += order.order_total()
    end
    return total_revenue
end

def top_customer(orders)
    max_revenue = -1.0/0.0 #neg infinity
    customer = nil
    for order in orders
        total = order.order_total()
        if total > max_revenue
            max_revenue = total
            customer = order.customer
        end
    end
    return customer
end

def best_selling_item(orders)
    all_items = {}
    for order in orders
        for item in order.items
            #puts(item)
            if all_items.has_key?(item["name"])
                all_items[item["name"]] += item["quantity"]
            else
                all_items[item["name"]] = item["quantity"]
            end
        end
    end

    top_selling_item = nil
    top_selling_qty = -1.0/0.0
    #puts(all_items)

    all_items.each_key do |item|
        if all_items[item] > top_selling_qty
            top_selling_item = item
            top_selling_qty = all_items[item]
        end
    end

    return top_selling_item
end

def average_order_value(orders)
    total = total_revenue(orders)
    len = orders.length()
    return total / len 
end

def orders_above(orders, min_total)
    result = []
    for order in orders
        if order.order_total() >= min_total
            result.append(order)
        end
    end

    return result
end

orders = [
    Order.new(1, "Alice", [
        {"name"=>"Book", "unit_price"=>12.99, "quantity"=>2},
        {"name"=>"Pen", "unit_price"=>1.49, "quantity"=>5}
    ]),
    Order.new(2, "Bob", [
        {"name"=>"Notebook", "unit_price"=>5.99, "quantity"=>3}
    ]),
    Order.new(3, "Alice", [
        {"name"=>"Pencil", "unit_price"=>0.99, "quantity"=>10}
    ]),
    Order.new(4, "Charlie", [
        {"name"=>"Book", "unit_price"=>12.99, "quantity"=>1},
        {"name"=>"Notebook", "unit_price"=>5.99, "quantity"=>2}
    ])
]

puts ("Total Cost of order 0 : " + orders[0].order_total().to_s)
puts ("Total Revenue : " + total_revenue(orders).to_s)
puts ("Top Customer : " + top_customer(orders).to_s)
puts ("Top Selling Item : " + best_selling_item(orders).to_s)
puts ("Average Order Value : " + average_order_value(orders).to_s)
puts ("")
puts ("Orders above 20 : ")
arr = orders_above(orders, 20)
for a in arr
    print a.id, " ", a.customer, " ", a.items, "\n"
end
