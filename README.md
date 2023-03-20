# dealership-database
Coding Temple Weekend Project #5

***

This is my fifth weekend project for Coding Temple. The assignment was to make a database for a car dealership, using **Lucidchart** to create the ERD and **PostgreSQL** via **DBeaver** to make and populate the database itself.

My initial database design was a symmetrical structure with the car as the central hub; on the sales side, the car was connected through the invoice to the customer and salesperson, while on the service side, it was connected through the service ticket to the mechanic and service record. All entities were thus at least indirectly connected and could access each other via joins. However, it turned out that this structure, while aesthetically pleasing, did not match the requirements of the project. In particular, customers had to be able to service their car at the dealership without necessarily buying it there, which meant they couldn't rely on the invoice to connect them (via car) to the service side of the dealership. Instead I had to rather inelegantly connect the customer 'across the divide' to the service ticket.

In creating the ERD my goal was visual clarity. A secondary goal was to eliminate any swastika figures that emerged as a result lines intersecting.

I've intentionally left my DDL and DML files a little bit messy so as not to erase the record of the process of my creation of the database. It wasn't until I was actually entering in data that I realized that some of columns I'd included (for example, a primary key column on the Service Record table) were superfluous. The code may not be the cleanest, but it is a much better indicator of my learning and thought process than if I'd revised it after the fact.

