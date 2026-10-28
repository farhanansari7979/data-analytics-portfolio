/* =====================================================================
   Project  : Online Bookstore Analysis
   Database : PostgreSQL
   Tables   : Books, Customers, Orders
   Contents : Table creation, CSV import, 20 business questions
                (11 basic + 9 advanced)
   ===================================================================== */


/* =====================================================================
   PART 1: DATABASE SETUP
   Note: change the CSV file paths below to match your own computer.
   ===================================================================== */

-- Books table
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id        SERIAL PRIMARY KEY,
    title          VARCHAR(100),
    author         VARCHAR(100),
    genre          VARCHAR(50),
    published_year INT,
    price          NUMERIC(10,2),
    stock          INT
);

COPY books (book_id, title, author, genre, published_year, price, stock)
FROM 'C:/Csv files/Books.csv'
DELIMITER ','
CSV HEADER;

-- Customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(100),
    email       VARCHAR(100),
    phone       VARCHAR(15),
    city        VARCHAR(50),
    country     VARCHAR(150)
);

COPY customers (customer_id, name, email, phone, city, country)
FROM 'C:/Csv files/Customers.csv'
DELIMITER ','
CSV HEADER;

-- Orders table (linked to books and customers through foreign keys)
CREATE TABLE orders (
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT,
    book_id      INT,
    order_date   DATE,
    quantity     INT,
    total_amount NUMERIC(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (book_id)     REFERENCES books (book_id)
);

COPY orders (order_id, customer_id, book_id, order_date, quantity, total_amount)
FROM 'C:/Csv files/Orders.csv'
DELIMITER ','
CSV HEADER;

-- Quick check that the data loaded correctly
SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;


/* =====================================================================
   PART 2: BASIC QUESTIONS
   ===================================================================== */

-- Q1. Retrieve all books in the "Fiction" genre.
SELECT *
FROM books
WHERE genre = 'Fiction';


-- Q2. Find books published after the year 1950.
SELECT *
FROM books
WHERE published_year > 1950;


-- Q3. List all customers from Canada.
SELECT *
FROM customers
WHERE country = 'Canada';


-- Q4. Show orders placed in November 2023.
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'
ORDER BY order_date;


-- Q5. Retrieve the total stock of books available.
SELECT SUM(stock) AS total_stock
FROM books;


-- Q6. Find the details of the most expensive book.
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;


-- Q7. Show all customers who ordered more than 1 quantity of a book.
SELECT c.name, o.quantity
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.quantity > 1
ORDER BY c.name;


-- Q8. Retrieve all orders where the total amount exceeds $20.
SELECT *
FROM orders
WHERE total_amount > 20;


-- Q9. List all genres available in the Books table.
SELECT DISTINCT genre
FROM books;


-- Q10. Find the book with the lowest stock.
SELECT *
FROM books
ORDER BY stock ASC
LIMIT 1;


-- Q11. Calculate the total revenue generated from all orders.
SELECT SUM(total_amount) AS total_revenue
FROM orders;


/* =====================================================================
   PART 3: ADVANCED QUESTIONS
   ===================================================================== */

-- Q12. Retrieve the total number of books sold for each genre.
SELECT b.genre,
       SUM(o.quantity) AS total_books_sold
FROM books AS b
JOIN orders AS o
    ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY total_books_sold DESC;


-- Q13. Find the average price of books in the "Fantasy" genre.
SELECT AVG(price) AS avg_fantasy_price
FROM books
WHERE genre = 'Fantasy';


-- Q14. List customers who have placed at least 2 orders.
SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2
ORDER BY c.customer_id ASC;


-- Q15. Find the most frequently ordered book.
SELECT b.title,
       COUNT(o.order_id) AS times_ordered
FROM books AS b
JOIN orders AS o
    ON b.book_id = o.book_id
GROUP BY b.title
ORDER BY times_ordered DESC
LIMIT 1;


-- Q16. Show the top 3 most expensive books of the 'Fantasy' genre.
SELECT title, genre, price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- Q17. Retrieve the total quantity of books sold by each author.
SELECT b.author,
       SUM(o.quantity) AS total_books_sold
FROM books AS b
JOIN orders AS o
    ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY total_books_sold DESC;


-- Q18. List the cities where customers who spent over $30 are located.
SELECT DISTINCT c.city
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;


-- Q19. Find the customer who spent the most on orders.
SELECT c.customer_id,
       c.name,
       SUM(o.total_amount) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;


-- Q20. Calculate the stock remaining after fulfilling all orders.
SELECT b.book_id,
       b.title,
       b.stock,
       COALESCE(SUM(o.quantity), 0)            AS total_ordered,
       b.stock - COALESCE(SUM(o.quantity), 0)  AS remaining_stock
FROM books AS b
LEFT JOIN orders AS o
    ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;
