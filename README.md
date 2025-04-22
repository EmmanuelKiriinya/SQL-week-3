# SQL Query Results Documentation

**Schema:** `luxteaching`

## Queries and Results

```sql
-- Set schema
set search_path to luxteaching;

-- 1. All customers with their full name and city
SELECT CONCAT(first_name, ' ', last_name) AS Names, city FROM customers;
```
**Output:**  
![output1](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output1.png)

---

```sql
-- 2. All books priced above 2000
SELECT * FROM books WHERE price > 2000;
```
**Output:**  
![output2](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output2.png)

---

```sql
-- 3. Customers living in Nairobi
SELECT * FROM customers WHERE city = 'Nairobi';
```
**Output:**  
![output3](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output3.png)

---

```sql
-- 4. All book titles published in 2023
SELECT * FROM books WHERE published_date BETWEEN '2023-01-01' AND '2023-12-31';
```
**Output:**  
![output4](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output4.png)

---

```sql
-- 5. All orders placed after March 1st 2025
SELECT * FROM orders WHERE order_date > '2025-03-01';
```
**Output:**  
![output5](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output5.png)

---

```sql
-- 6. All books ordered, sorted by price (descending)
SELECT orders.order_id, books.title, books.price FROM books
INNER JOIN orders ON books.book_id = orders.book_id ORDER BY price DESC;
```
**Output:**  
![output6](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output6.png)

---

```sql
-- 7. All customers whose names start with 'J'
SELECT * FROM customers WHERE first_name LIKE 'J%';
```
**Output:**  
![output7](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output7.png)

---

```sql
-- 8. Books with price between 1500 and 3000
SELECT * FROM books WHERE price BETWEEN 1500 AND 3000;
```
**Output:**  
![output8](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output8.png)

---

```sql
-- 9. Count the number of customers in each city
SELECT city, COUNT(*) AS Number_of_customers FROM customers GROUP BY city;
```
**Output:**  
![output9](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output9.png)

---

```sql
-- 10. Total number of orders per customer
SELECT customer_id, COUNT(customer_id) AS Total_number_of_orders FROM orders GROUP BY customer_id;
```
**Output:**  
![output10](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output10.png)

---

```sql
-- 11. Average price of books in the store
SELECT AVG(price) AS Average_price FROM books;
```
**Output:**  
![output11](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output11.png)

---

```sql
-- 12. Book title and total quantity ordered for each book
SELECT books.title, SUM(orders.quantity) AS quantity_ordered FROM books
LEFT JOIN orders ON books.book_id = orders.book_id GROUP BY books.title;
```
**Output:**  
![output12](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output12.png)

---

```sql
-- 13. Customers who have placed more orders than customer with ID =1
SELECT customer_id, COUNT(*) AS customer_orders FROM orders GROUP BY customer_id
HAVING COUNT(*) > (SELECT COUNT(*) FROM orders WHERE customer_id = 1);
```
**Output:**  
![output13](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output13.png)

---

```sql
-- 14. Books more expensive than the average book price
SELECT title FROM books WHERE price > (SELECT AVG(price) FROM books);
```
**Output:**  
![output14](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output14.png)

---

```sql
-- 15. Each customer and the number of orders they placed (subquery in SELECT)
SELECT c.customer_id, c.first_name, (
    SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id
) AS total_orders FROM customers c;
```
**Output:**  
![output15](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output15.png)

---

```sql
-- 16. Show full name of each customer and the titles of books they ordered
SELECT CONCAT(customers.first_name, ' ', customers.last_name) AS Full_name, books.title
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN books ON books.book_id = orders.book_id;
```
**Output:**  
![output16](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output16.png)

---

```sql
-- 17. All orders including book title, quantity, total cost
SELECT books.title, orders.quantity, books.price * orders.quantity AS Total_cost
FROM books JOIN orders ON books.book_id = orders.book_id;
```
**Output:**  
![output17](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output17.png)

---

```sql
-- 18. Customers who haven't placed any orders yet
SELECT c.first_name, c.last_name, o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE order_id IS NULL;
```
**Output:**  
![output18](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output18.png)

---

```sql
-- 19. All books and Customers who ordered them
SELECT books.title, customers.first_name, customers.last_name FROM orders
LEFT JOIN books ON orders.book_id = books.book_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id;
```
**Output:**  
![output19](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output19.png)

---

```sql
-- 20. Customers who live in the same city
SELECT a.first_name, a.last_name, b.city FROM customers a
JOIN customers b ON a.city = b.city;
```
**Output:**  
![output20](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output20.png)

---

```sql
-- 21. All customers who placed more than 2 orders for books priced over 2000
SELECT c.customer_id, c.first_name, c.last_name, COUNT(*) AS "Order > 2"
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id WHERE b.price > 2000
GROUP BY c.customer_id, c.first_name, c.last_name HAVING COUNT(*) > 1;
```
**Output:**  
![output21](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output21.png)

---

```sql
-- 22. Customers who ordered the same book more than once
SELECT DISTINCT b.title, o.customer_id, c.first_name, COUNT(o.book_id) AS total_order
FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN books b ON b.book_id = o.book_id
GROUP BY o.customer_id, c.first_name, b.title HAVING COUNT(o.book_id) > 1;
```
**Output:**  
![output22](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output22.png)

---

```sql
-- 23. Each customer's full name, total quantity of books ordered, and total amount spent
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Names, SUM(o.quantity) AS total_quantity,
b.price * o.quantity AS Total_amount FROM orders o
JOIN books b ON o.book_id = b.book_id JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name, b.price, o.quantity;
```
**Output:**  
![output23](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output23.png)

---

```sql
-- 24. Books that have never been ordered
SELECT b.title, o.order_id FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id WHERE order_id IS NULL;
```
**Output:**  
![output24](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output24.png)

---

```sql
-- 25. Customer who has spent the most in total
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Names, SUM(o.quantity * b.price) AS total_cost
FROM orders o JOIN books b ON o.book_id = b.book_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name ORDER BY total_cost DESC LIMIT 1;
```
**Output:**  
![output25](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output25.png)

---

```sql
-- 26. Each book and the number of different customers who ordered it
SELECT b.title, COUNT(c.customer_id) AS Number_of_customers FROM orders o
LEFT JOIN books b ON b.book_id = o.book_id
LEFT JOIN customers c ON c.customer_id = o.customer_id GROUP BY b.title;
```
**Output:**  
![output26](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output26.png)


---

```sql
-- 27. Books whose total order quantity is above the average order quantity
SELECT b.book_id, b.title FROM books b JOIN (
    SELECT book_id, SUM(quantity) AS total_quantity FROM orders
    GROUP BY book_id HAVING SUM(quantity) > (SELECT AVG(quantity) FROM orders)
) o ON b.book_id = o.book_id;
```
**Output:**  
![output27](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output27.png)

---

```sql
-- 28. Top 3 customers with the highest number of orders and the total amount they spent
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Names,
       SUM(o.quantity * b.price) AS total_amount_spent,
       COUNT(o.book_id)
FROM orders o JOIN books b ON o.book_id = b.book_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name ORDER BY total_amount_spent DESC LIMIT 3;
```
**Output:**  
![output28](https://github.com/EmmanuelKiriinya/SQL-week-3/blob/main/Customers%20submission/Output28.png)
