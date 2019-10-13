/*Steven Woodard
5-Mar-19
Lab 12*/

/*#1*/
/*Assignment 1:List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books ;*/
SELECT title, retail 
	FROM books
	WHERE retail < 
    (SELECT AVG(retail) 
    FROM books
    );


/*#2*/
/*Assignment 3:  Determine which orders were shipped to the same state as order 1014*/
SELECT order# 
  FROM orders
  WHERE shipstate = 
    (SELECT shipstate 
    FROM orders
    WHERE order# = 1014);

/*#3*/
/*Assignment 4: Determine which orders had a higher total amount due than order 1008*/
SELECT order#, SUM(paideach*quantity)
  FROM orderitems
  GROUP BY order#
  HAVING SUM(quantity*paideach) > (SELECT SUM(quantity*paideach)
                            FROM orderitems
                            WHERE order# = 1008);


/*#4*/
/*Assignment 6: List the title of all books in the same category as books previously purchased by customer 1007. 
Don’t include books this customer has already purchased.*/
SELECT b.title 
  FROM books b, (SELECT bc.category 
                  FROM orderitems i, books bc 
                  WHERE order# = ANY(SELECT order# 
                                      FROM orders 
                                      WHERE i.isbn = bc.isbn 
                                      AND customer# = 1007)
  ) ppc
  WHERE b.category = ppc.category
  AND b.title NOT IN(SELECT DISTINCT bc.title 
                      FROM orderitems i, books bc 
                      WHERE order# = ANY(SELECT order# 
                                      FROM orders 
                                      WHERE i.isbn = bc.isbn 
                                      AND customer# = 1007)
  )
  GROUP BY b.title
;


/*#5*/
/*Assignment 8: Determine which customers placed orders for the least expensive book 
(in terms of regular retail price) carried by JustLee Books*/
SELECT o.customer# 
  FROM orders o
  WHERE o.order# IN (SELECT i.order# 
                      FROM orderitems i, books b
                      WHERE b.isbn = i.isbn
                      AND b.retail = (SELECT MIN(retail) FROM books));



/*#6*/
/*Assignment 10: Determine which books were published by the publisher of The Wok Way to Cook*/
SELECT * FROM books WHERE pubid = (SELECT pubid FROM books WHERE title = 'THE WOK WAY TO COOK');

