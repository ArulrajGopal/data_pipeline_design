-- drop table order_details;
-- drop table order_items;
-- drop table orders;
-- drop table order_items_stage;
-- drop table orders_stage;


CREATE TABLE IF NOT EXISTS orders_stage (
    order_id INT NOT NULL,    
    customer_id INT NOT NULL,        
    order_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS order_items_stage (
    order_item_id INT NOT NULL,
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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    PRIMARY KEY (order_id, order_item_id)
);



CREATE OR REPLACE PROCEDURE load_orders()
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO orders (order_id, customer_id, order_date)
    SELECT 
        order_id,
        customer_id,
        order_date
    FROM orders_stage
    ON CONFLICT (order_id) DO UPDATE
    SET
        customer_id = EXCLUDED.customer_id,
        order_date = EXCLUDED.order_date,
        updated_at = NOW();

    RAISE NOTICE 'Orders table upserted successfully.';
END;
$$;


CREATE OR REPLACE PROCEDURE load_order_items()
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO order_items (order_item_id, order_id, product_id, unit_price, qty)
    SELECT 
    order_item_id,
    order_id,
    product_id,
    unit_price,
    qty
    FROM order_items_stage
    ON CONFLICT (order_item_id) DO UPDATE
    SET
        order_id = EXCLUDED.order_id,
        product_id = EXCLUDED.product_id,
        unit_price = EXCLUDED.unit_price,
        qty = EXCLUDED.qty,
        updated_at = NOW();


    RAISE NOTICE 'order_items table loaded successfully.';
END;
$$;



-- CREATE OR REPLACE PROCEDURE load_order_details()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN

--     TRUNCATE TABLE order_details;

--     INSERT INTO order_details (order_id, customer_id, order_date, order_item_id, product_id,unit_price,qty)
--     SELECT 
--         A.order_id,
--         A.customer_id,
--         A.order_date,
--         B.order_item_id,
--         B.product_id,
--         B.unit_price,
--         B.qty
--     FROM orders A 
--     join order_items B
--     on A.order_id = B.order_id;


--     RAISE NOTICE 'order_details table loaded successfully.';
-- END;
-- $$;

-- with 
-- order_with_order_items as (
-- select B.order_id, B.order_item_id, A.order_date,  B.product_id, A.customer_id, B.unit_price, B.qty 
-- from orders_stage A 
-- join order_items B 
-- on A.order_id = B.order_id
-- ),

-- orders_items_filtered as (
-- select A.*
-- from order_items_stage A 
-- left join orders_stage B
-- on A.order_id = B.order_id
-- where B.order_id is null
-- )

-- select B.order_id, B.customer_id, B.order_date, A.order_item_id,  A.product_id,  A.unit_price, A.qty 
-- from orders_items_filtered A 
-- join orders B
-- on A.order_id = B.order_id;


