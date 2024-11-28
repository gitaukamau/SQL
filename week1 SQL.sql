create database ABC_DATA;
use ABC_DATA;

create table customers(
customerid  int primary key,
first_name varchar(20),
last_name varchar(20),
email varchar(70)
);

create table products(
productid int primary key,
product_name varchar (70),
price int
);

create table orders(
orderid int primary key,
customerid int, foreign key(customerid) references customers(customerid) on delete cascade,
order_date date
);

create table order_items(
orderid int, foreign key (orderid) references orders(orderid)on update cascade,
productid int,foreign key(productid)references products(productid),
quantity int
);


INSERT INTO customers (customerid, first_name, last_name, email) VALUE
(1, 'John', 'Doe', 'johndoe@email.com'),
(2, 'Jane', 'Smith', 'janesmith@email.com'),
(3, 'Bob', 'Johnson', 'bobjohnson@email.com'),
(4, 'Alice', 'Brown', 'alicebrown@email.com'),
(5, 'Charlie', 'Davis', 'charliedavis@email.com'),
(6, 'Eva', 'Fisher', 'evafisher@email.com'),
(7, 'George', 'Harris', 'georgeharris@email.com'),
(8, 'Ivy', 'Jones', 'ivyjones@email.com'),
(9, 'Kevin', 'Miller', 'kevinmiller@email.com'),
(10, 'Lily', 'Nelson', 'lilynelson@email.com'),
(11, 'Oliver', 'Patterson', 'oliverpatterson@email.com'),
(12, 'Quinn', 'Roberts', 'quinnroberts@email.com'),
(13, 'Sophia', 'Thomas', 'sophiathomas@email.com')
;
    
     INSERT INTO products (productid, product_name, price) VALUES
    (1, 'Product A', 10.00),
    (2, 'Product B', 15.00),
    (3, 'Product C', 20.00),
    (4, 'Product D', 25.00),
    (5, 'Product E', 30.00),
    (6, 'Product F', 35.00),
    (7, 'Product G', 40.00),
    (8, 'Product H', 45.00),
    (9, 'Product I', 50.00),
    (10, 'Product J', 55.00),
    (11, 'Product K', 60.00),
    (12, 'Product L', 65.00),
    (13, 'Product M', 70.00);
    
    INSERT INTO orders (orderid, customerid, order_date) VALUES
    (1, 1, '2023-05-01'),
    (2, 2, '2023-05-02'),
    (3, 3, '2023-05-03'),
    (4, 1, '2023-05-04'),
    (5, 2, '2023-05-05'),
    (6, 3, '2023-05-06'),
    (7, 4, '2023-05-07'),
    (8, 5, '2023-05-08'),
    (9, 6, '2023-05-09'),
    (10, 7, '2023-05-10'),
    (11, 8, '2023-05-11'),
    (12, 9, '2023-05-12'),
    (13, 10, '2023-05-13'),
    (14, 11, '2023-05-14'),
    (15, 12, '2023-05-15'),
    (16, 13, '2023-05-16');
    
    INSERT INTO order_items (orderid, productid, quantity) VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 2, 1),
    (2, 3, 3),
    (3, 1, 1),
    (3, 3, 2),
    (4, 2, 4),
    (4, 3, 1),
    (5, 1, 1),
    (5, 3, 2),
    (6, 2, 3),
    (6, 1, 1),
    (7, 4, 1),
    (7, 5, 2),
    (8, 6, 3),
    (8, 7, 1),
    (9, 8, 2),
    (9, 9, 1),
    (10, 10, 3),
    (10, 11, 2),
    (11, 12, 1),
    (11, 13, 3),
    (12, 4, 2),
    (12, 5, 1),
    (13, 6, 3),
    (13, 7, 2),
    (14, 8, 1),
    (14, 9, 2),
    (15, 10, 3),
    (15, 11, 1),
    (16, 12, 2),
    (16, 13, 3);

-- Which product has the highest price? Only return a single row

select * from products
where price = (select max(price) from products);

-- Which order_id had the highest number of items in terms of quantity;

select orderid from order_items 
where quantity = (select max(quantity) from order_items);

-- Which customer has made the most orders?
select c.customerid, c.first_name, c.Last_name, count(o.orderid) as total_orders
from customers c
join orders o
on c.customerid = o.customerid
group by o.customerid
having total_orders >1;

-- What’s the total revenue per product?
select product_name, o.productid, sum(quantity*price) as total_amounts
from order_items o
join products p
on o.productid = p.productid
group by o.productid;
  
-- Find the first order (by date) for each customer.
select * from orders
order by customerid,order_date;

-- Find the day with the highest revenue. 
select order_date, total_revenue 
from
(select o.order_date,sum(oi.quantity*p.price)as total_revenue
from orders o
join order_items oi
on o.orderid = oi.orderid
join products p
on oi.productid = p.productid
group by o.order_date) as totals
where total_revenue = (select max(sum(oi.quantity*p.price))as total_revenue
from orders o
join order_items oi
on o.orderid = oi.orderid
join products p
on oi.productid = p.productid
group by o.order_date 
);
 


select o.order_date, sum(oi.quantity*p.price)as total_revenue
from orders o
join order_items oi
on o.orderid = oi.orderid
join products p
on oi.productid = p.productid
group by o.order_date
order by total_revenue desc 
limit 1;





