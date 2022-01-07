DROP TABLE IF EXISTS people;
CREATE TABLE people(
   Person VARCHAR(17) NOT NULL PRIMARY KEY
  ,Region VARCHAR(7) NOT NULL
);
INSERT INTO people(returned, order_id) VALUES ('Anna Andreadi','West');
INSERT INTO people(returned, order_id) VALUES ('Chuck Magee','East');
INSERT INTO people(returned, order_id) VALUES ('Kelly Williams','Central');
INSERT INTO people(returned, order_id) VALUES ('Cassandra Brandow','South');