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
];

def total_price(order)
    tp = 0;
    tp += order[:items].sum {|item| item[:unit_price]*item[:quantity]};
    return tp;
end

def total_revenue(orders)
    tr = 0;
    for i in orders
        tr += total_price(i);
    end
    return tr;
end

def max_spent(orders)
    m_spent = Hash.new();
    for i in orders
        tp = total_price(i);
        m_spent[i[:customer]] ||=0;
        m_spent[i[:customer]]+=tp;
    end
    a,v =  m_spent.max_by {|_,v| v};
    return a
end

def best_item(orders)
    b_pur = Hash.new(0);
    for i in orders
        for j in i[:items]
            b_pur[j[:name]]+=j[:quantity];
        end
    end
    a,v = b_pur.max_by {|_,v| v};
    return a;
end

def avg_ord(orders)
    x = total_revenue(orders);
    y = orders.length;
    return x/y;
end

def gt_amount(amount,orders)
    arr = Array.new();
    for i in orders
        x = total_price(i);
        if x > amount
            arr.push(i);
        end
    end
    return arr;
end
puts total_price(orders[0]);
puts total_revenue(orders);
puts max_spent(orders);
puts best_item(orders);
puts avg_ord(orders);
puts gt_amount(30,orders);


