CREATE DATABASE retail;

USE retail;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_department_id` int(11) NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_fname` varchar(45) NOT NULL,
  `customer_lname` varchar(45) NOT NULL,
  `customer_email` varchar(45) NOT NULL,
  `customer_password` varchar(45) NOT NULL,
  `customer_street` varchar(255) NOT NULL,
  `customer_city` varchar(45) NOT NULL,
  `customer_state` varchar(45) NOT NULL,
  `customer_zipcode` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12436 DEFAULT CHARSET=utf8;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(45) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_item_order_id` int(11) NOT NULL,
  `order_item_product_id` int(11) NOT NULL,
  `order_item_quantity` tinyint(4) NOT NULL,
  `order_item_subtotal` float NOT NULL,
  `order_item_product_price` float NOT NULL,
  PRIMARY KEY (`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=172199 DEFAULT CHARSET=utf8;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `order_customer_id` int(11) NOT NULL,
  `order_status` varchar(45) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68884 DEFAULT CHARSET=utf8;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_category_id` int(11) NOT NULL,
  `product_name` varchar(45) NOT NULL,
  `product_description` varchar(255) NOT NULL,
  `product_price` float NOT NULL,
  `product_image` varchar(255) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1346 DEFAULT CHARSET=utf8;

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

