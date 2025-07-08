-- drop table order_details;
-- drop table order_items;
-- drop table orders;
-- drop table order_items_stage;
-- drop table orders_stage;


CREATE TABLE IF NOT EXISTS orders_stage (
    order_id INTEGER PRIMARY KEY,      
    customer_id INT NOT NULL,        
    order_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS order_items_stage (
    order_id INT NOT NULL,             
    product_id INT NOT NULL,   
    unit_price DECIMAL(10, 2) NOT NULL,      
    qty INT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,      
    customer_id INT NOT NULL,        
    order_date DATE NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INTEGER PRIMARY KEY, 
    order_id INT NOT NULL,             
    product_id INT NOT NULL,   
    unit_price DECIMAL(10, 2) NOT NULL,      
    qty INT NOT NULL,      
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_details (
    order_item_id INT NOT NULL,             
    order_id INT NOT NULL,             
    product_id INT NOT NULL, 
    customer_id INT NOT NULL,        
    order_date DATE NOT NULL,  
    unit_price DECIMAL(10, 2) NOT NULL,      
    qty INT NOT NULL,      
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           
    PRIMARY KEY (order_id, order_item_id),  
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id) ON DELETE CASCADE
);
