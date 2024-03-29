SELECT MAX(lineitem.l_shipdate) , supplier.s_phone,lineitem.l_returnflag,lineitem.l_shipdate 
FROM partsupp,supplier,lineitem,part 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY supplier.s_acctbal,supplier.s_phone,lineitem.l_returnflag,lineitem.l_shipdate 
ORDER BY lineitem.l_shipdate  


SELECT orders.o_orderpriority,supplier.s_name,nation.n_comment 
FROM supplier,nation,customer,orders 
WHERE nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderpriority = '3-MEDIUM       ' AND supplier.s_name = 'Supplier#000000073       ' AND nation.n_comment IS NOT NULL AND orders.o_orderpriority = '3-MEDIUM       ' 
GROUP BY customer.c_phone,supplier.s_address,supplier.s_nationkey,orders.o_orderpriority,supplier.s_name,nation.n_comment   
LIMIT 4

SELECT MAX(partsupp.ps_availqty) , part.p_comment,partsupp.ps_availqty 
FROM partsupp,part 
WHERE part.p_partkey = partsupp.ps_partkey 
GROUP BY part.p_comment,partsupp.ps_availqty 
ORDER BY part.p_comment  


SELECT MIN(orders.o_totalprice) , orders.o_totalprice,lineitem.l_shipdate 
FROM orders,lineitem,supplier 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_shipdate = date '1993-10-17' AND lineitem.l_shipdate = date '1993-10-17' AND lineitem.l_shipdate = date '1993-10-17' AND lineitem.l_shipdate = date '1993-10-17' 
GROUP BY orders.o_totalprice,lineitem.l_shipdate    


SELECT COUNT(lineitem.l_returnflag) , lineitem.l_returnflag 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_returnflag = 'N' 
GROUP BY orders.o_comment,orders.o_totalprice,lineitem.l_returnflag 
ORDER BY lineitem.l_returnflag  


SELECT lineitem.l_tax,supplier.s_name,nation.n_comment,lineitem.l_linenumber,lineitem.l_discount 
FROM partsupp,lineitem,supplier,nation 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY partsupp.ps_availqty,supplier.s_nationkey,lineitem.l_tax,supplier.s_name,nation.n_comment,lineitem.l_linenumber,lineitem.l_discount   
LIMIT 5

SELECT MAX(orders.o_totalprice) , orders.o_totalprice,orders.o_orderstatus,orders.o_clerk 
FROM region,nation,customer,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY customer.c_nationkey,nation.n_comment,orders.o_totalprice,orders.o_orderstatus,orders.o_clerk 
ORDER BY orders.o_orderstatus 
LIMIT 3

SELECT MIN(lineitem.l_extendedprice) , lineitem.l_returnflag,lineitem.l_comment,lineitem.l_extendedprice,part.p_type 
FROM orders,lineitem,part 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_comment = 'refully regular' 
GROUP BY lineitem.l_orderkey,lineitem.l_returnflag,lineitem.l_comment,lineitem.l_extendedprice,part.p_type 
ORDER BY lineitem.l_returnflag  

SELECT MIN(lineitem.l_shipdate) , part.p_size,lineitem.l_shipdate,orders.o_orderdate 
FROM part,lineitem,orders,customer 
WHERE lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY part.p_container,part.p_brand,part.p_name,part.p_size,lineitem.l_shipdate,orders.o_orderdate 
ORDER BY orders.o_orderdate  

SELECT MIN(customer.c_mktsegment) , customer.c_mktsegment 
FROM region,nation,supplier,customer 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_mktsegment = 'AUTOMOBILE' 
GROUP BY customer.c_mktsegment   
LIMIT 3

SELECT lineitem.l_quantity,lineitem.l_shipinstruct,supplier.s_acctbal 
FROM orders,lineitem,supplier 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_shipinstruct = 'COLLECT COD              ' 
GROUP BY orders.o_totalprice,lineitem.l_shipmode,orders.o_shippriority,lineitem.l_quantity,lineitem.l_shipinstruct,supplier.s_acctbal 
ORDER BY lineitem.l_quantity,lineitem.l_shipinstruct,supplier.s_acctbal 
LIMIT 4

SELECT MIN(orders.o_orderdate) , lineitem.l_returnflag,orders.o_orderdate,part.p_name 
FROM part,partsupp,lineitem,orders 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_partkey = lineitem.l_partkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY lineitem.l_receiptdate,lineitem.l_returnflag,orders.o_orderdate,part.p_name 
ORDER BY lineitem.l_returnflag,orders.o_orderdate,part.p_name 
LIMIT 4

SELECT MAX(lineitem.l_tax) , lineitem.l_tax,lineitem.l_linenumber 
FROM part,partsupp,lineitem,orders 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_partkey = lineitem.l_partkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_linenumber > 2 
GROUP BY partsupp.ps_comment,lineitem.l_shipdate,lineitem.l_discount,lineitem.l_tax,lineitem.l_linenumber 
ORDER BY lineitem.l_tax,lineitem.l_linenumber  

SELECT lineitem.l_linenumber 
FROM lineitem,part,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY lineitem.l_linenumber 
ORDER BY lineitem.l_linenumber 
LIMIT 3

SELECT nation.n_name 
FROM nation,customer,supplier 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY nation.n_comment,customer.c_nationkey,nation.n_name 
ORDER BY nation.n_name 
LIMIT 4

SELECT part.p_container 
FROM nation,supplier,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY supplier.s_phone,part.p_name,partsupp.ps_supplycost,part.p_container 
ORDER BY part.p_container 
LIMIT 4

SELECT MIN(part.p_size) , part.p_size 
FROM part,lineitem,supplier,customer 
WHERE lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY supplier.s_comment,lineitem.l_comment,part.p_size 
ORDER BY part.p_size 
LIMIT 3

SELECT customer.c_phone 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_name,supplier.s_name,customer.c_phone    

SELECT lineitem.l_discount,lineitem.l_receiptdate,lineitem.l_quantity,partsupp.ps_supplycost 
FROM partsupp,lineitem 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey 
GROUP BY lineitem.l_shipinstruct,lineitem.l_partkey,lineitem.l_tax,lineitem.l_discount,lineitem.l_receiptdate,lineitem.l_quantity,partsupp.ps_supplycost   
LIMIT 3

SELECT lineitem.l_shipmode,supplier.s_address 
FROM supplier,partsupp,part,lineitem 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND supplier.s_address = 'fRJimA7zchyApqRLHcQeocVpP' AND supplier.s_address = 'fRJimA7zchyApqRLHcQeocVpP' AND lineitem.l_shipmode = 'AIR       ' 
GROUP BY part.p_brand,supplier.s_nationkey,lineitem.l_shipmode,supplier.s_address 
ORDER BY lineitem.l_shipmode,supplier.s_address  

SELECT COUNT(supplier.s_phone) , lineitem.l_shipmode,supplier.s_phone,lineitem.l_shipinstruct,lineitem.l_comment 
FROM lineitem,part,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY supplier.s_address,lineitem.l_linenumber,lineitem.l_shipmode,supplier.s_phone,lineitem.l_shipinstruct,lineitem.l_comment 
ORDER BY lineitem.l_shipmode,supplier.s_phone,lineitem.l_shipinstruct  

SELECT COUNT(customer.c_comment) , customer.c_mktsegment,customer.c_comment 
FROM nation,customer 
WHERE nation.n_nationkey = customer.c_nationkey 
GROUP BY customer.c_acctbal,customer.c_phone,customer.c_name,customer.c_mktsegment,customer.c_comment 
ORDER BY customer.c_mktsegment,customer.c_comment 
LIMIT 5

SELECT part.p_container 
FROM nation,supplier,lineitem,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_shipdate,lineitem.l_comment,part.p_container   
LIMIT 5

SELECT lineitem.l_shipdate 
FROM partsupp,supplier,lineitem 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY lineitem.l_shipdate   
LIMIT 3

SELECT MIN(nation.n_name) , supplier.s_address,customer.c_mktsegment,nation.n_name,lineitem.l_extendedprice,customer.c_phone 
FROM customer,nation,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY lineitem.l_quantity,customer.c_acctbal,supplier.s_address,customer.c_mktsegment,nation.n_name,lineitem.l_extendedprice,customer.c_phone    

SELECT customer.c_mktsegment,orders.o_totalprice 
FROM customer,orders 
WHERE customer.c_custkey = orders.o_custkey 
GROUP BY orders.o_orderpriority,customer.c_comment,orders.o_orderkey,customer.c_mktsegment,orders.o_totalprice 
ORDER BY customer.c_mktsegment 
LIMIT 3

SELECT customer.c_comment,customer.c_phone,supplier.s_comment 
FROM partsupp,supplier,nation,customer 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND supplier.s_comment = 'ctions: quickly final courts wake quietly foxes. packages hag' 
GROUP BY nation.n_nationkey,customer.c_comment,customer.c_phone,supplier.s_comment 
ORDER BY customer.c_comment,customer.c_phone,supplier.s_comment  

SELECT lineitem.l_shipmode,lineitem.l_shipdate,partsupp.ps_availqty,lineitem.l_extendedprice 
FROM partsupp,part,lineitem,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND partsupp.ps_availqty < 5256 
GROUP BY lineitem.l_shipmode,lineitem.l_shipdate,partsupp.ps_availqty,lineitem.l_extendedprice 
ORDER BY lineitem.l_shipmode,lineitem.l_shipdate,partsupp.ps_availqty,lineitem.l_extendedprice  

SELECT supplier.s_name,nation.n_name,part.p_mfgr,nation.n_comment,part.p_size,lineitem.l_returnflag 
FROM part,lineitem,supplier,nation 
WHERE lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey AND part.p_size = 26 
GROUP BY lineitem.l_linenumber,part.p_brand,supplier.s_name,nation.n_name,part.p_mfgr,nation.n_comment,part.p_size,lineitem.l_returnflag   
LIMIT 5

SELECT COUNT(region.r_comment) , region.r_comment 
FROM lineitem,supplier,nation,region 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey AND region.r_comment = 'hs use ironic, even requests. s' 
GROUP BY lineitem.l_commitdate,region.r_comment 
ORDER BY region.r_comment  

SELECT COUNT(orders.o_orderstatus) , lineitem.l_commitdate,orders.o_orderstatus,orders.o_shippriority,lineitem.l_quantity 
FROM customer,orders,lineitem,part 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_receiptdate,customer.c_nationkey,lineitem.l_commitdate,orders.o_orderstatus,orders.o_shippriority,lineitem.l_quantity 
ORDER BY lineitem.l_quantity  

SELECT MIN(nation.n_name) , nation.n_name 
FROM region,nation,supplier,lineitem 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY nation.n_regionkey,supplier.s_nationkey,lineitem.l_quantity,nation.n_name 
ORDER BY nation.n_name 
LIMIT 3

SELECT COUNT(part.p_container) , part.p_container,partsupp.ps_supplycost,customer.c_name 
FROM part,partsupp,supplier,nation,customer 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY part.p_container,partsupp.ps_supplycost,customer.c_name    

SELECT part.p_comment,orders.o_shippriority,lineitem.l_discount,orders.o_orderdate,lineitem.l_linenumber 
FROM part,lineitem,orders,customer 
WHERE lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY part.p_mfgr,part.p_comment,orders.o_shippriority,lineitem.l_discount,orders.o_orderdate,lineitem.l_linenumber    

SELECT MAX(orders.o_orderpriority) , lineitem.l_shipmode,orders.o_orderpriority,orders.o_totalprice 
FROM orders,lineitem 
WHERE orders.o_orderkey = lineitem.l_orderkey AND orders.o_orderpriority = '1-URGENT       ' AND orders.o_orderpriority = '1-URGENT       ' 
GROUP BY lineitem.l_shipmode,orders.o_orderpriority,orders.o_totalprice    

SELECT region.r_comment,region.r_name 
FROM region 
WHERE  region.r_name = 'AMERICA                  ' AND region.r_comment IS NOT NULL 
GROUP BY region.r_comment,region.r_name    

SELECT SUM(lineitem.l_extendedprice) , lineitem.l_discount,lineitem.l_extendedprice,lineitem.l_quantity,customer.c_mktsegment,nation.n_name,lineitem.l_tax 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND nation.n_name = 'IRAQ                     ' AND customer.c_mktsegment = 'FURNITURE ' 
GROUP BY lineitem.l_shipdate,orders.o_orderstatus,lineitem.l_discount,lineitem.l_extendedprice,lineitem.l_quantity,customer.c_mktsegment,nation.n_name,lineitem.l_tax    

SELECT MAX(lineitem.l_comment) , lineitem.l_comment 
FROM customer,supplier,lineitem,part 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_comment = 'sleep blithe' AND lineitem.l_comment = 'sleep blithe' AND lineitem.l_comment = 'sleep blithe' AND lineitem.l_comment = 'sleep blithe' 
GROUP BY supplier.s_name,part.p_brand,lineitem.l_commitdate,lineitem.l_comment 
ORDER BY lineitem.l_comment 
LIMIT 71063

SELECT supplier.s_phone,customer.c_phone,supplier.s_acctbal 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_nationkey,supplier.s_phone,customer.c_phone,supplier.s_acctbal   
LIMIT 29078

SELECT MIN(lineitem.l_returnflag) , lineitem.l_returnflag 
FROM partsupp,lineitem 
WHERE partsupp.ps_partkey = lineitem.l_partkey 
GROUP BY lineitem.l_returnflag    

SELECT MAX(nation.n_comment) , nation.n_comment,customer.c_name,customer.c_comment 
FROM supplier,nation,customer 
WHERE nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_name = 'Customer#000001052' 
GROUP BY supplier.s_suppkey,nation.n_comment,customer.c_name,customer.c_comment 
ORDER BY customer.c_comment 
LIMIT 46296

SELECT orders.o_orderdate,orders.o_orderpriority,partsupp.ps_availqty,lineitem.l_shipmode 
FROM orders,lineitem,part,partsupp 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY orders.o_orderdate,orders.o_orderpriority,partsupp.ps_availqty,lineitem.l_shipmode    

SELECT customer.c_acctbal,orders.o_orderstatus,customer.c_mktsegment 
FROM orders,customer,nation,supplier 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND customer.c_mktsegment = 'MACHINERY ' 
GROUP BY nation.n_name,supplier.s_name,supplier.s_acctbal,customer.c_acctbal,orders.o_orderstatus,customer.c_mktsegment 
ORDER BY orders.o_orderstatus,customer.c_mktsegment  

SELECT partsupp.ps_comment,lineitem.l_shipinstruct 
FROM part,lineitem,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_shipinstruct = 'COLLECT COD              ' AND partsupp.ps_comment = ' even frets. even sentiments are along the furiously quick d' 
GROUP BY partsupp.ps_comment,lineitem.l_shipinstruct    

SELECT COUNT(customer.c_mktsegment) , part.p_size,customer.c_mktsegment,lineitem.l_shipinstruct 
FROM customer,supplier,lineitem,part 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND part.p_size <= 48 
GROUP BY lineitem.l_discount,part.p_retailprice,supplier.s_address,part.p_size,customer.c_mktsegment,lineitem.l_shipinstruct 
ORDER BY customer.c_mktsegment  

SELECT SUM(lineitem.l_discount) , lineitem.l_discount,lineitem.l_shipmode,part.p_brand,lineitem.l_linestatus 
FROM part,partsupp,supplier,lineitem 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_shipmode = 'SHIP      ' 
GROUP BY part.p_retailprice,lineitem.l_receiptdate,lineitem.l_discount,lineitem.l_shipmode,part.p_brand,lineitem.l_linestatus 
ORDER BY lineitem.l_discount,lineitem.l_shipmode,part.p_brand,lineitem.l_linestatus  

SELECT MIN(lineitem.l_shipdate) , lineitem.l_comment,orders.o_orderpriority,lineitem.l_shipdate,lineitem.l_tax,lineitem.l_shipinstruct 
FROM partsupp,supplier,lineitem,orders 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY lineitem.l_comment,orders.o_orderpriority,lineitem.l_shipdate,lineitem.l_tax,lineitem.l_shipinstruct    

SELECT COUNT(supplier.s_address) , supplier.s_address 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_address,supplier.s_address    

SELECT lineitem.l_comment,lineitem.l_extendedprice,lineitem.l_discount 
FROM lineitem,supplier,partsupp 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_comment = 'iously pending instructions above ' AND lineitem.l_comment = 'iously pending instructions above ' AND lineitem.l_comment = 'iously pending instructions above ' 
GROUP BY supplier.s_suppkey,partsupp.ps_availqty,lineitem.l_comment,lineitem.l_extendedprice,lineitem.l_discount   
LIMIT 71176

SELECT orders.o_clerk,customer.c_acctbal,lineitem.l_shipinstruct,orders.o_orderstatus,lineitem.l_discount 
FROM customer,orders,lineitem,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND orders.o_clerk = 'Clerk#000000906' 
GROUP BY partsupp.ps_partkey,lineitem.l_partkey,customer.c_phone,orders.o_clerk,customer.c_acctbal,lineitem.l_shipinstruct,orders.o_orderstatus,lineitem.l_discount 
ORDER BY orders.o_clerk,customer.c_acctbal,lineitem.l_discount 
LIMIT 57071

SELECT COUNT(customer.c_comment) , lineitem.l_comment,customer.c_name,lineitem.l_tax,customer.c_comment 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY customer.c_acctbal,lineitem.l_comment,customer.c_name,lineitem.l_tax,customer.c_comment 
ORDER BY lineitem.l_tax  

SELECT lineitem.l_shipmode,lineitem.l_comment,customer.c_address 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY orders.o_totalprice,lineitem.l_receiptdate,orders.o_clerk,lineitem.l_shipmode,lineitem.l_comment,customer.c_address    

SELECT MAX(orders.o_orderstatus) , supplier.s_address,orders.o_orderpriority,orders.o_orderstatus,orders.o_comment,customer.c_mktsegment 
FROM supplier,nation,customer,orders 
WHERE nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY supplier.s_address,orders.o_orderpriority,orders.o_orderstatus,orders.o_comment,customer.c_mktsegment   
LIMIT 64267

SELECT orders.o_clerk 
FROM region,nation,customer,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY customer.c_custkey,orders.o_totalprice,orders.o_orderstatus,orders.o_clerk    

SELECT part.p_container,part.p_size,lineitem.l_shipmode 
FROM orders,lineitem,part,partsupp 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND part.p_container = 'JUMBO CAN ' 
GROUP BY part.p_partkey,lineitem.l_extendedprice,partsupp.ps_supplycost,part.p_container,part.p_size,lineitem.l_shipmode 
ORDER BY part.p_size 
LIMIT 8053

SELECT MAX(region.r_name) , region.r_name,nation.n_comment,supplier.s_acctbal 
FROM region,nation,supplier,customer 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY region.r_name,nation.n_comment,supplier.s_acctbal 
ORDER BY supplier.s_acctbal 
LIMIT 40769

SELECT part.p_name,lineitem.l_comment,lineitem.l_shipinstruct,lineitem.l_shipdate 
FROM lineitem,part,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY partsupp.ps_supplycost,supplier.s_name,part.p_name,lineitem.l_comment,lineitem.l_shipinstruct,lineitem.l_shipdate 
ORDER BY lineitem.l_comment,lineitem.l_shipinstruct  

SELECT nation.n_name,supplier.s_name,customer.c_name,partsupp.ps_availqty,customer.c_mktsegment 
FROM nation,customer,supplier,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND supplier.s_name = 'Supplier#000000117       ' AND partsupp.ps_availqty >= 1859 AND supplier.s_name = 'Supplier#000000117       ' AND partsupp.ps_availqty > 6341 
GROUP BY supplier.s_nationkey,supplier.s_comment,nation.n_name,supplier.s_name,customer.c_name,partsupp.ps_availqty,customer.c_mktsegment 
ORDER BY partsupp.ps_availqty 
LIMIT 77507

SELECT MAX(customer.c_name) , nation.n_comment,customer.c_name,supplier.s_address 
FROM customer,nation,supplier 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_comment IS NOT NULL 
GROUP BY nation.n_nationkey,supplier.s_nationkey,nation.n_comment,customer.c_name,supplier.s_address   
LIMIT 70747

SELECT MIN(customer.c_address) , customer.c_address 
FROM part,partsupp,supplier,customer,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY customer.c_address   
LIMIT 12210

SELECT lineitem.l_receiptdate 
FROM supplier,partsupp,part,lineitem 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_receiptdate = date '1998-03-23' AND lineitem.l_receiptdate = date '1998-03-23' AND lineitem.l_receiptdate = date '1998-03-23' AND lineitem.l_receiptdate = date '1998-03-23' 
GROUP BY part.p_size,partsupp.ps_partkey,lineitem.l_receiptdate   
LIMIT 6758

SELECT COUNT(partsupp.ps_comment) , partsupp.ps_comment 
FROM partsupp,lineitem,supplier,nation 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY lineitem.l_discount,partsupp.ps_comment    

SELECT MAX(lineitem.l_receiptdate) , lineitem.l_returnflag,lineitem.l_discount,lineitem.l_linestatus,lineitem.l_receiptdate,part.p_brand,part.p_mfgr 
FROM lineitem,part,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY supplier.s_comment,lineitem.l_returnflag,lineitem.l_discount,lineitem.l_linestatus,lineitem.l_receiptdate,part.p_brand,part.p_mfgr   
LIMIT 14736

SELECT partsupp.ps_supplycost,lineitem.l_receiptdate,lineitem.l_commitdate 
FROM lineitem,partsupp,supplier,nation 
WHERE partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_commitdate = date '1995-04-16' AND lineitem.l_commitdate = date '1995-04-16' 
GROUP BY nation.n_comment,supplier.s_suppkey,partsupp.ps_supplycost,lineitem.l_receiptdate,lineitem.l_commitdate 
ORDER BY lineitem.l_commitdate  

SELECT MIN(part.p_type) , part.p_type 
FROM nation,supplier,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY supplier.s_address,part.p_type    

SELECT SUM(lineitem.l_discount) , lineitem.l_tax,lineitem.l_discount,lineitem.l_commitdate,customer.c_comment,orders.o_totalprice,orders.o_shippriority 
FROM partsupp,lineitem,orders,customer 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY lineitem.l_suppkey,customer.c_mktsegment,lineitem.l_tax,lineitem.l_discount,lineitem.l_commitdate,customer.c_comment,orders.o_totalprice,orders.o_shippriority 
ORDER BY lineitem.l_tax,lineitem.l_discount,lineitem.l_commitdate,orders.o_totalprice,orders.o_shippriority  

SELECT part.p_name,lineitem.l_tax,part.p_mfgr,lineitem.l_commitdate,lineitem.l_shipmode,part.p_brand 
FROM partsupp,part,lineitem 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY part.p_size,part.p_name,lineitem.l_tax,part.p_mfgr,lineitem.l_commitdate,lineitem.l_shipmode,part.p_brand    

SELECT COUNT(lineitem.l_commitdate) , lineitem.l_commitdate,orders.o_comment 
FROM supplier,customer,orders,lineitem 
WHERE customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND orders.o_comment = 'ously. unusual deposits wake. furiously bold foxes sleep bold, bold' AND orders.o_comment = 'ously. unusual deposits wake. furiously bold foxes sleep bold, bold' 
GROUP BY lineitem.l_commitdate,orders.o_comment 
ORDER BY lineitem.l_commitdate,orders.o_comment  

SELECT COUNT(lineitem.l_linenumber) , lineitem.l_linenumber,partsupp.ps_comment,supplier.s_name,lineitem.l_quantity 
FROM part,partsupp,lineitem,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_partkey = lineitem.l_partkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY lineitem.l_linenumber,partsupp.ps_comment,supplier.s_name,lineitem.l_quantity 
ORDER BY lineitem.l_linenumber,partsupp.ps_comment  

SELECT part.p_mfgr,partsupp.ps_comment,supplier.s_name,lineitem.l_receiptdate 
FROM partsupp,part,lineitem,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY part.p_mfgr,partsupp.ps_comment,supplier.s_name,lineitem.l_receiptdate   
LIMIT 2132

SELECT customer.c_mktsegment 
FROM orders,customer,supplier 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_comment,customer.c_custkey,customer.c_mktsegment 
ORDER BY customer.c_mktsegment 
LIMIT 36412

SELECT supplier.s_comment,customer.c_acctbal,customer.c_comment,supplier.s_name 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_name = 'Supplier#000000116       ' 
GROUP BY region.r_name,supplier.s_phone,region.r_regionkey,supplier.s_comment,customer.c_acctbal,customer.c_comment,supplier.s_name   
LIMIT 708

SELECT MIN(nation.n_name) , nation.n_name,supplier.s_acctbal 
FROM partsupp,supplier,nation 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY nation.n_comment,supplier.s_suppkey,nation.n_name,supplier.s_acctbal   
LIMIT 17331

SELECT COUNT(lineitem.l_comment) , lineitem.l_comment 
FROM customer,nation,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY supplier.s_nationkey,lineitem.l_comment 
ORDER BY lineitem.l_comment 
LIMIT 27782

SELECT supplier.s_name,partsupp.ps_availqty 
FROM region,nation,supplier,partsupp 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_availqty = 1859 
GROUP BY supplier.s_name,partsupp.ps_availqty   
LIMIT 11899

SELECT AVG(lineitem.l_linenumber) , part.p_comment,lineitem.l_linenumber,part.p_type 
FROM supplier,lineitem,part 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND part.p_comment = 'y special plat' 
GROUP BY part.p_comment,lineitem.l_linenumber,part.p_type 
ORDER BY part.p_comment 
LIMIT 51565

SELECT customer.c_address 
FROM orders,customer,nation,supplier 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY supplier.s_acctbal,customer.c_comment,customer.c_address    

SELECT MIN(lineitem.l_commitdate) , lineitem.l_commitdate 
FROM supplier,lineitem,partsupp 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_commitdate = date '1993-09-28' AND lineitem.l_commitdate = date '1993-09-28' AND lineitem.l_commitdate = date '1993-09-28' 
GROUP BY lineitem.l_commitdate 
ORDER BY lineitem.l_commitdate 
LIMIT 54015

SELECT region.r_name,supplier.s_acctbal 
FROM part,partsupp,supplier,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY part.p_mfgr,supplier.s_comment,part.p_type,region.r_name,supplier.s_acctbal   
LIMIT 71877

SELECT COUNT(partsupp.ps_comment) , lineitem.l_receiptdate,lineitem.l_shipdate,lineitem.l_extendedprice,partsupp.ps_comment 
FROM customer,orders,lineitem,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_suppkey = lineitem.l_suppkey 
GROUP BY partsupp.ps_suppkey,lineitem.l_discount,lineitem.l_receiptdate,lineitem.l_shipdate,lineitem.l_extendedprice,partsupp.ps_comment   
LIMIT 41846

SELECT part.p_mfgr 
FROM part,partsupp,supplier,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY part.p_mfgr   
LIMIT 59688

SELECT lineitem.l_shipmode,supplier.s_address,lineitem.l_tax 
FROM partsupp,part,lineitem,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY lineitem.l_shipmode,supplier.s_address,lineitem.l_tax 
ORDER BY lineitem.l_shipmode,supplier.s_address,lineitem.l_tax 
LIMIT 38820

SELECT lineitem.l_comment,lineitem.l_shipmode,lineitem.l_quantity,supplier.s_name 
FROM customer,supplier,lineitem,part 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY part.p_type,lineitem.l_comment,lineitem.l_shipmode,lineitem.l_quantity,supplier.s_name 
ORDER BY lineitem.l_comment 
LIMIT 50154

SELECT MAX(lineitem.l_tax) , lineitem.l_tax,orders.o_clerk,lineitem.l_returnflag 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY orders.o_custkey,lineitem.l_suppkey,customer.c_mktsegment,lineitem.l_tax,orders.o_clerk,lineitem.l_returnflag 
ORDER BY lineitem.l_tax,orders.o_clerk,lineitem.l_returnflag 
LIMIT 30072

SELECT part.p_comment,partsupp.ps_availqty,part.p_container,part.p_size 
FROM nation,supplier,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND part.p_size <= 47 
GROUP BY supplier.s_acctbal,nation.n_comment,part.p_comment,partsupp.ps_availqty,part.p_container,part.p_size 
ORDER BY part.p_comment,part.p_container  

SELECT COUNT(part.p_brand) , part.p_container,supplier.s_name,part.p_brand,partsupp.ps_availqty 
FROM part,lineitem,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_availqty <= 4703 
GROUP BY part.p_container,supplier.s_name,part.p_brand,partsupp.ps_availqty   
LIMIT 15877

SELECT customer.c_name,supplier.s_acctbal,customer.c_phone,supplier.s_phone 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_phone = '22-966-435-7200' 
GROUP BY nation.n_name,customer.c_name,supplier.s_acctbal,customer.c_phone,supplier.s_phone   
LIMIT 5630

SELECT lineitem.l_extendedprice,lineitem.l_returnflag,lineitem.l_shipdate 
FROM nation,supplier,partsupp,lineitem 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_returnflag = 'A' AND lineitem.l_shipdate = date '1994-04-27' AND lineitem.l_shipdate = date '1994-04-27' 
GROUP BY lineitem.l_shipmode,lineitem.l_extendedprice,lineitem.l_returnflag,lineitem.l_shipdate    

SELECT COUNT(customer.c_name) , supplier.s_comment,customer.c_name 
FROM customer,supplier,partsupp 
WHERE customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY supplier.s_comment,customer.c_name   
LIMIT 69750

SELECT customer.c_mktsegment,nation.n_name 
FROM region,nation,customer,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_mktsegment = 'HOUSEHOLD ' AND nation.n_name = 'IRAN                     ' AND nation.n_name = 'IRAN                     ' AND nation.n_name = 'IRAN                     ' 
GROUP BY supplier.s_nationkey,region.r_name,customer.c_nationkey,customer.c_mktsegment,nation.n_name   
LIMIT 36165

SELECT lineitem.l_commitdate,orders.o_shippriority,lineitem.l_linenumber 
FROM orders,lineitem,partsupp,supplier 
WHERE orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY lineitem.l_quantity,lineitem.l_commitdate,orders.o_shippriority,lineitem.l_linenumber 
ORDER BY lineitem.l_commitdate,lineitem.l_linenumber  

SELECT MAX(orders.o_orderstatus) , orders.o_orderstatus 
FROM orders,customer,supplier 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND orders.o_orderstatus = 'F' AND orders.o_orderstatus = 'F' AND orders.o_orderstatus = 'F' 
GROUP BY customer.c_custkey,customer.c_nationkey,orders.o_orderstatus 
ORDER BY orders.o_orderstatus 
LIMIT 10786

SELECT COUNT(customer.c_mktsegment) , orders.o_orderdate,customer.c_mktsegment,orders.o_clerk,nation.n_name 
FROM orders,customer,nation,supplier 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND orders.o_orderdate = date '1994-09-24' 
GROUP BY customer.c_comment,orders.o_orderkey,supplier.s_suppkey,orders.o_orderdate,customer.c_mktsegment,orders.o_clerk,nation.n_name 
ORDER BY orders.o_clerk,nation.n_name 
LIMIT 1292

SELECT COUNT(lineitem.l_linenumber) , lineitem.l_linenumber 
FROM supplier,partsupp,part,lineitem 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_linenumber   
LIMIT 18072

SELECT nation.n_name 
FROM region,nation,supplier,lineitem 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY lineitem.l_partkey,lineitem.l_suppkey,lineitem.l_tax,nation.n_name 
ORDER BY nation.n_name 
LIMIT 71322

SELECT lineitem.l_returnflag,part.p_mfgr,lineitem.l_commitdate,part.p_name,lineitem.l_linestatus 
FROM customer,supplier,lineitem,part 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_returnflag,part.p_mfgr,lineitem.l_commitdate,part.p_name,lineitem.l_linestatus   
LIMIT 31985

SELECT customer.c_address,nation.n_name,orders.o_totalprice 
FROM orders,customer,nation,supplier 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY customer.c_acctbal,customer.c_address,nation.n_name,orders.o_totalprice    

SELECT MIN(lineitem.l_commitdate) , lineitem.l_shipinstruct,partsupp.ps_comment,lineitem.l_commitdate 
FROM part,lineitem,partsupp,supplier 
WHERE lineitem.l_partkey = part.p_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY part.p_type,supplier.s_address,lineitem.l_shipinstruct,partsupp.ps_comment,lineitem.l_commitdate 
ORDER BY lineitem.l_shipinstruct,partsupp.ps_comment,lineitem.l_commitdate  

SELECT MAX(supplier.s_name) , customer.c_phone,supplier.s_name,customer.c_name 
FROM nation,customer,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY customer.c_phone,supplier.s_name,customer.c_name    

SELECT AVG(lineitem.l_linenumber) , lineitem.l_linenumber,lineitem.l_shipmode,part.p_name 
FROM supplier,lineitem,part,partsupp 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND part.p_name = 'antique grey misty medium firebrick' 
GROUP BY lineitem.l_orderkey,lineitem.l_extendedprice,lineitem.l_linenumber,lineitem.l_shipmode,part.p_name   
LIMIT 47973

SELECT MAX(supplier.s_phone) , supplier.s_phone 
FROM supplier,customer,orders,lineitem 
WHERE customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY lineitem.l_receiptdate,supplier.s_phone 
ORDER BY supplier.s_phone  

SELECT MAX(lineitem.l_shipmode) , lineitem.l_shipmode 
FROM nation,customer,orders,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_shipmode = 'REG AIR   ' AND lineitem.l_shipmode = 'REG AIR   ' AND lineitem.l_shipmode = 'REG AIR   ' 
GROUP BY customer.c_name,orders.o_clerk,lineitem.l_partkey,lineitem.l_shipmode   
LIMIT 44758

SELECT COUNT(supplier.s_comment) , supplier.s_comment 
FROM customer,supplier,partsupp 
WHERE customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND supplier.s_comment = 'd. instructions integrate sometimes slyly pending instructions. accounts nag among the ' AND supplier.s_comment = 'd. instructions integrate sometimes slyly pending instructions. accounts nag among the ' 
GROUP BY customer.c_nationkey,partsupp.ps_supplycost,partsupp.ps_suppkey,supplier.s_comment 
ORDER BY supplier.s_comment 
LIMIT 41471

SELECT COUNT(supplier.s_name) , supplier.s_name,supplier.s_comment,supplier.s_address,supplier.s_acctbal,lineitem.l_commitdate 
FROM nation,customer,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_commitdate = date '1997-09-19' AND lineitem.l_commitdate = date '1997-09-19' 
GROUP BY lineitem.l_suppkey,supplier.s_name,supplier.s_comment,supplier.s_address,supplier.s_acctbal,lineitem.l_commitdate    

SELECT MIN(orders.o_totalprice) , lineitem.l_quantity,orders.o_totalprice,supplier.s_address 
FROM nation,supplier,lineitem,orders 
WHERE nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND supplier.s_address = 'vdWe5lfgvisRCxdd85DTOZHqAzcuq7f7KKThA' AND supplier.s_address = 'vdWe5lfgvisRCxdd85DTOZHqAzcuq7f7KKThA' 
GROUP BY lineitem.l_quantity,orders.o_totalprice,supplier.s_address 
ORDER BY lineitem.l_quantity 
LIMIT 17108

SELECT part.p_mfgr,part.p_name,orders.o_comment,customer.c_phone 
FROM part,lineitem,orders,customer 
WHERE lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY part.p_retailprice,part.p_mfgr,part.p_name,orders.o_comment,customer.c_phone    

SELECT customer.c_mktsegment,orders.o_orderdate,supplier.s_address,customer.c_name,orders.o_shippriority,customer.c_comment 
FROM partsupp,supplier,customer,orders 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderdate = date '1995-11-28' 
GROUP BY orders.o_comment,partsupp.ps_availqty,supplier.s_nationkey,customer.c_mktsegment,orders.o_orderdate,supplier.s_address,customer.c_name,orders.o_shippriority,customer.c_comment   
LIMIT 26561

SELECT AVG(lineitem.l_extendedprice) , lineitem.l_extendedprice,orders.o_totalprice,supplier.s_address 
FROM customer,orders,lineitem,supplier 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey = supplier.s_suppkey AND supplier.s_address = 'C4nPvLrVmKPPabFCj' AND supplier.s_address = 'C4nPvLrVmKPPabFCj' 
GROUP BY customer.c_acctbal,lineitem.l_extendedprice,orders.o_totalprice,supplier.s_address 
ORDER BY orders.o_totalprice,supplier.s_address  

SELECT nation.n_name,supplier.s_name,lineitem.l_shipdate 
FROM nation,supplier,lineitem,partsupp 
WHERE nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey 
GROUP BY lineitem.l_linestatus,lineitem.l_suppkey,lineitem.l_discount,nation.n_name,supplier.s_name,lineitem.l_shipdate 
ORDER BY nation.n_name,supplier.s_name,lineitem.l_shipdate  

SELECT lineitem.l_receiptdate,lineitem.l_extendedprice,lineitem.l_linestatus 
FROM customer,orders,lineitem,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_partkey = lineitem.l_partkey 
GROUP BY lineitem.l_receiptdate,lineitem.l_extendedprice,lineitem.l_linestatus   
LIMIT 15659

SELECT MIN(customer.c_phone) , region.r_comment,orders.o_shippriority,customer.c_phone,orders.o_comment,customer.c_address 
FROM region,nation,customer,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY region.r_comment,orders.o_shippriority,customer.c_phone,orders.o_comment,customer.c_address 
ORDER BY region.r_comment,customer.c_address  

SELECT nation.n_comment,nation.n_name 
FROM nation  
GROUP BY nation.n_regionkey,nation.n_nationkey,nation.n_comment,nation.n_name 
ORDER BY nation.n_comment,nation.n_name 
LIMIT 14947

SELECT part.p_name,part.p_retailprice,part.p_size 
FROM part,partsupp 
WHERE part.p_partkey = partsupp.ps_partkey 
GROUP BY partsupp.ps_suppkey,part.p_mfgr,part.p_name,part.p_retailprice,part.p_size   
LIMIT 10200

SELECT COUNT(supplier.s_name) , customer.c_mktsegment,supplier.s_name 
FROM supplier,nation,customer,orders 
WHERE nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY orders.o_comment,customer.c_mktsegment,supplier.s_name    

SELECT region.r_name 
FROM part,partsupp,supplier,customer,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY customer.c_mktsegment,region.r_name    

SELECT customer.c_acctbal,customer.c_comment 
FROM customer  
GROUP BY customer.c_custkey,customer.c_acctbal,customer.c_comment 
ORDER BY customer.c_acctbal  

SELECT part.p_mfgr,supplier.s_address,nation.n_name 
FROM nation,supplier,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND part.p_mfgr LIKE 'Manufacture%' AND part.p_mfgr LIKE 'Manufacture%' AND supplier.s_address LIKE '1KhUgZegwM%' AND part.p_mfgr = 'Manufacturer#5           ' 
GROUP BY part.p_mfgr,supplier.s_address,nation.n_name    

SELECT COUNT(customer.c_comment) , supplier.s_comment,customer.c_comment 
FROM customer,nation,supplier,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_comment = 'ions. furiously unusual platelets cajole blithely. caref' 
GROUP BY nation.n_nationkey,supplier.s_suppkey,customer.c_mktsegment,supplier.s_comment,customer.c_comment 
ORDER BY supplier.s_comment,customer.c_comment  

SELECT SUM(orders.o_totalprice) , orders.o_orderdate,lineitem.l_shipinstruct,orders.o_totalprice,lineitem.l_shipmode 
FROM partsupp,lineitem,orders,customer 
WHERE partsupp.ps_suppkey = lineitem.l_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderdate = date '1995-11-01' 
GROUP BY orders.o_orderdate,lineitem.l_shipinstruct,orders.o_totalprice,lineitem.l_shipmode   
LIMIT 5365

SELECT lineitem.l_discount,lineitem.l_shipdate 
FROM orders,lineitem,partsupp,supplier 
WHERE orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_partkey = lineitem.l_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' AND lineitem.l_shipdate = date '1997-04-30' 
GROUP BY orders.o_clerk,supplier.s_phone,orders.o_orderdate,lineitem.l_discount,lineitem.l_shipdate   
LIMIT 56019

SELECT MAX(orders.o_shippriority) , orders.o_shippriority 
FROM nation,supplier,customer,orders 
WHERE nation.n_nationkey = supplier.s_nationkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY customer.c_custkey,orders.o_comment,orders.o_shippriority 
ORDER BY orders.o_shippriority  

SELECT part.p_size,nation.n_name,partsupp.ps_availqty,nation.n_comment 
FROM nation,supplier,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY nation.n_nationkey,partsupp.ps_partkey,nation.n_regionkey,part.p_size,nation.n_name,partsupp.ps_availqty,nation.n_comment 
ORDER BY nation.n_name  

SELECT lineitem.l_shipmode,customer.c_comment,customer.c_acctbal,supplier.s_address 
FROM customer,nation,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_partkey = supplier.s_suppkey AND supplier.s_address LIKE 'cqjyB5%' 
GROUP BY lineitem.l_shipmode,customer.c_comment,customer.c_acctbal,supplier.s_address   
LIMIT 39833

SELECT MIN(lineitem.l_shipdate) , lineitem.l_shipdate,lineitem.l_extendedprice,supplier.s_phone,customer.c_name,supplier.s_acctbal,supplier.s_name 
FROM customer,supplier,lineitem,part 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_partkey = supplier.s_suppkey AND lineitem.l_suppkey = part.p_partkey 
GROUP BY supplier.s_suppkey,lineitem.l_orderkey,part.p_type,lineitem.l_shipdate,lineitem.l_extendedprice,supplier.s_phone,customer.c_name,supplier.s_acctbal,supplier.s_name 
ORDER BY lineitem.l_shipdate,lineitem.l_extendedprice,supplier.s_phone,customer.c_name 
LIMIT 1251

SELECT MAX(lineitem.l_comment) , partsupp.ps_comment,supplier.s_acctbal,lineitem.l_comment 
FROM lineitem,partsupp,supplier,nation 
WHERE partsupp.ps_partkey = lineitem.l_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND partsupp.ps_comment = ' accounts alongside of the slyly even accounts wake carefully final instructions-- ruthless platelets wake carefully ideas. even deposits are quickly final,' 
GROUP BY lineitem.l_commitdate,partsupp.ps_partkey,partsupp.ps_suppkey,partsupp.ps_comment,supplier.s_acctbal,lineitem.l_comment   
LIMIT 41292

SELECT COUNT(lineitem.l_linenumber) , lineitem.l_linenumber,orders.o_orderdate 
FROM lineitem,orders,customer,nation 
WHERE orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY lineitem.l_linenumber,orders.o_orderdate    

SELECT lineitem.l_receiptdate 
FROM orders,customer,supplier,lineitem 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_partkey = supplier.s_suppkey AND lineitem.l_receiptdate = date '1995-01-10' AND lineitem.l_receiptdate = date '1995-01-10' AND lineitem.l_receiptdate = date '1995-01-10' AND lineitem.l_receiptdate = date '1995-01-10' 
GROUP BY orders.o_comment,orders.o_clerk,lineitem.l_receiptdate 
ORDER BY lineitem.l_receiptdate 
LIMIT 46841

SELECT COUNT(part.p_brand) , part.p_brand 
FROM lineitem,part,partsupp,supplier 
WHERE lineitem.l_suppkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY lineitem.l_extendedprice,part.p_brand   
LIMIT 43709

SELECT customer.c_comment 
FROM region,nation,customer 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY customer.c_comment    

SELECT orders.o_totalprice,orders.o_orderstatus 
FROM orders,customer,nation,supplier 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY nation.n_regionkey,customer.c_custkey,orders.o_orderpriority,orders.o_totalprice,orders.o_orderstatus 
ORDER BY orders.o_totalprice 
LIMIT 73217

SELECT SUM(partsupp.ps_availqty) , partsupp.ps_availqty 
FROM customer,nation,supplier,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY nation.n_name,partsupp.ps_availqty   
LIMIT 26397

SELECT MAX(supplier.s_phone) , supplier.s_phone 
FROM part,partsupp,supplier,customer,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY supplier.s_phone   
LIMIT 71881

