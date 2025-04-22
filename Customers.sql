--Specify your schema first
set search_path to luxteaching;

--BASIC QUERIES
--1. All customers with their full name and city
select concat(first_name,' ',last_name) as Names, city 
from customers;

--2. All books priced above 2000
select *
from books
where price > 2000;

--3. Customers living in Nairobi
select *
from customers
where city ='Nairobi';

--4. All book titles published in 2023
select *
from books
where published_date between '2023-01-01' and '2023-12-31';

-- FILTERING AND SORTING
--5. All orders placed after March 1st 2025
select *
from orders
where order_date > '2025-03-01';

--6. All books ordered, sorted by price(desceding)
select orders.order_id, books.title, books.price
from books
inner join orders on books.book_id = orders.book_id
order by price desc;

--7. All customers whose names start with 'J'
select *
from customers
where first_name like 'J%';

--8. Books with price between 1500 and 3000
select *
from books
where price between 1500 and 3000;

-- AGGREGATE FUNCTIONS AND GROUPING
--9. Count the number of customers in each city
select city, count(*) as Number_of_customers
from customers
group by city;

--10. Total number of orders per customer
select  customer_id, count(customer_id) as Total_number_of_orders
from orders 
group by customer_id;

--11. Average price of books in the store
select avg(price) as Average_price
from books;

--12. Book title and total quantity ordered for each books
select books.title, sum(orders.quantity) as quantity_ordered
from books
left join orders on books.book_id = orders.book_id
group by books.title;

-- SUBQUERIES
--13. Customers who have placed more orders than customer with ID =1
select customer_id, count(*) as customer_orders
from orders
group by customer_id
having count(*) > (select count(*) 
from orders
where customer_id = 1);

--14. Books expensive than the average book price
select title 
from books
where price > (select avg(price) from books);

--15. Each customer and the number of orders they place using a subquery in SELECT
select c.customer_id, c.first_name, (
        select count(*) 
        FROM orders o 
        WHERE o.customer_id = c.customer_id
    ) "total_orders"
from customers c;
-- JOINS
--16. Show full name of each customer and the titles of books they ordered

select concat(customers.first_name,' ',customers.last_name) as Full_name, books.title
from customers 
left join orders  on customers.customer_id = orders.customer_id
left join books on books.book_id = orders.book_id;

--17. All orders including book title, quantity, total cost
select books.title, orders.quantity, books.price * orders.quantity as Total_cost
from books
join orders on books.book_id = orders.book_id;

--18. Customers who haven't placed any orders yet
select c.first_name, c.last_name, o.order_id
from customers c
left join orders o on c.customer_id = o.customer_id
where order_id isnull;

--19. All books and Customers who ordered them
select books.title, customers.first_name, customers.last_name
from orders
left join books on orders.book_id = books.book_id
left join customers on orders.customer_id = customers.customer_id;

--20. Customers who live in the same city
select a.first_name, a.last_name, b.city
from customers a
join customers b on a.city = b.city;

-- COMBINED LOGIC
--21. All customers who placed more than 2 orders for books priced over 2000
select c.customer_id, c.first_name, c.last_name,  count(*) "Order > 2"
from customers c
join orders o on c.customer_id = o.customer_id
join books b on o.book_id = b.book_id
where b.price > 2000
group by c.customer_id, c.first_name, c.last_name
having count(*) > 1;

--22. Customers who ordered the same book more than once
select distinct b.title,
	o.customer_id,
	c.first_name,
	count(o.book_id) as total_order
from customers c 
inner join orders o on c.customer_id = o.customer_id
inner join books b on b.book_id = o.book_id
group by o.customer_id, c.first_name, b.title
having count(o.book_id) > 1;

--23. Show each customer's full name, total quantity of books ordered, and total amount spent
select concat(c.first_name, ' ', c.last_name) as Names, sum(o.quantity) as total_qantity,
b.price * o.quantity as Total_amount
from orders o
join books b on o.book_id = b.book_id
join customers c on c.customer_id = o.customer_id
group by c.first_name, c.last_name, b.price, o.quantity;

--24. Books that have never been ordered
select b.title, o.order_id
from books b
left join orders o on b.book_id = o.book_id
where order_id isnull;

--25. Customer who has spent the most in total
select concat(c.first_name, ' ', c.last_name) as Names, sum(o.quantity*b.price) as total_cost
from orders o
join books b on o.book_id = b.book_id
join customers c on c.customer_id = o.customer_id
group by c.first_name, c.last_name
order by sum(o.quantity*b.price) desc
limit 1;


--26. Each book with the and the number of different customers who have ordered it
select b.title, count(c.customer_id) as Number_of_customers
from orders o
left join books b  on b.book_id = o.book_id
left join customers c on c.customer_id = o.customer_id
group by b.title;

-- 27. List books whose total order quantity is above the average order quantity
SELECT 
    b.book_id,
    b.title
FROM 
    books b
JOIN (
    SELECT 
        book_id,
        SUM(quantity) AS total_quantity
    FROM 
        orders
    GROUP BY 
        book_id
    HAVING SUM(quantity) > (
        SELECT AVG(quantity) FROM orders
    )
) o ON b.book_id = o.book_id;


--28. Top 3 customers with the highest number of orders and the total amount they spent

select concat(c.first_name, ' ', c.last_name) as Names, sum(o.quantity*b.price) as total_amount_spent, count(o.book_id)
from orders o
join books b on o.book_id = b.book_id
join customers c on c.customer_id = o.customer_id
group by c.first_name, c.last_name
order by total_amount_spent  desc
limit 3;