USE retail;

ALTER TABLE categories
ADD CONSTRAINT fk_categories_departments
FOREIGN KEY (category_department_id)
REFERENCES departments(department_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (product_category_id)
REFERENCES categories(category_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (order_item_product_id)
REFERENCES products(product_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_item_order_id)
REFERENCES orders(order_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (order_customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;