# MuseumDB
I had to create a simple application that requires a database for my Database course at univeristy

# LAB 1
The database must contain at least: 10 tables, two 1:n relationships, one m:n relationship.

# LAB 2
On the relational structure created for the first lab, write SQL statements that:

insert data – for at least 4 tables; at least one statement must violate referential integrity constraints;
update data – for at least 3 tables;
delete data – for at least 2 tables.
In the UPDATE / DELETE statements, use at least once: {AND, OR, NOT},  {<,<=,=,>,>=,<> }, IS [NOT] NULL, IN, BETWEEN, LIKE.

On the same database, write the following SQL queries:

- a. 2 queries with the union operation; use UNION [ALL] and OR;
- b. 2 queries with the intersection operation; use INTERSECT and IN;
- c. 2 queries with the difference operation; use EXCEPT and NOT IN;
- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;
- e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause;
- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;
- g. 2 queries with a subquery in the FROM clause;                         
- h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;
- i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

# LAB 3

Write SQL scripts that:
a. modify the type of a column;
b. add / remove a column;
c. add / remove a DEFAULT constraint;
d. add / remove a primary key;
e. add / remove a candidate key;
f. add / remove a foreign key;
g. create / drop a table.

For each of the scripts above, write another one that reverts the operation. Place each script in a stored procedure. Use a simple, intuitive naming convention.

Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number.

Write a stored procedure that receives as a parameter a version number and brings the database to that version.

# LAB 5
Work on 3 tables of the form Ta(aid, a2, …), Tb(bid, b2, …), Tc(cid, aid, bid, …), where:

aid, bid, cid, a2, b2 are integers;
the primary keys are underlined;
a2 is UNIQUE in Ta;
aid and bid are foreign keys in Tc, referencing the primary keys in Ta and Tb, respectively.
a. Write queries on Ta such that their execution plans contain the following operators:

clustered index scan;
clustered index seek;
nonclustered index scan;
nonclustered index seek;
key lookup.
b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. Create a nonclustered index that can speed up the query. Examine the execution plan again.

c. Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.

