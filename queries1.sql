SELECT MIN(customer.c_nationkey) , MIN(lineitem.l_tax) , MAX(lineitem.l_commitdate) , SUM(part.tid) , MAX(part.tid) , AVG(part.tid) 
FROM nation,customer,supplier,partsupp,part,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_linenumber,lineitem.l_commitdate,customer.c_nationkey,lineitem.l_tax,nation.n_name,part.tid


SELECT MIN(supplier.s_name) , supplier.s_name,nation.n_name,customer.c_acctbal,lineitem.l_receiptdate,supplier.tid 
FROM customer,nation,supplier,partsupp,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_partkey = lineitem.l_partkey 
GROUP BY customer.c_custkey,customer.c_phone,supplier.s_address,supplier.s_name,nation.n_name,customer.c_acctbal,lineitem.l_receiptdate,supplier.tid 
ORDER BY supplier.s_name,supplier.tid  


SELECT orders.tid,lineitem.l_orderkey 
FROM partsupp,lineitem,orders,customer 
WHERE partsupp.ps_partkey = lineitem.l_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY orders.tid,lineitem.l_orderkey  


SELECT COUNT(supplier.s_nationkey) , MIN(supplier.s_name) , COUNT(supplier.s_name) , supplier.s_acctbal,supplier.s_name,nation.n_regionkey,supplier.s_nationkey,customer.c_comment 
FROM customer,supplier,nation,region 
WHERE customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY nation.tid,nation.n_comment,supplier.s_acctbal,supplier.s_name,nation.n_regionkey,supplier.s_nationkey,customer.c_comment


SELECT orders.o_orderdate,nation.n_nationkey 
FROM part,lineitem,orders,customer,supplier,nation,region 
WHERE lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey AND nation.n_nationkey >= 0 
GROUP BY orders.o_orderpriority,orders.o_orderdate,nation.n_nationkey  


SELECT lineitem.l_suppkey,supplier.tid,supplier.s_name,lineitem.l_partkey 
FROM part,partsupp,lineitem,supplier,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY part.p_retailprice,lineitem.l_returnflag,lineitem.l_shipinstruct,lineitem.l_suppkey,supplier.tid,supplier.s_name,lineitem.l_partkey 
ORDER BY supplier.tid,supplier.s_name 
LIMIT 5

SELECT lineitem.l_returnflag,lineitem.tid,supplier.s_phone,lineitem.l_commitdate 
FROM customer,supplier,lineitem 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY customer.c_acctbal,lineitem.l_returnflag,lineitem.tid,supplier.s_phone,lineitem.l_commitdate


SELECT MAX(nation.n_name) 
FROM supplier,lineitem,orders,customer,nation,region 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY supplier.s_address,lineitem.l_linenumber,supplier.s_acctbal,customer.c_acctbal,customer.c_name,nation.n_name


SELECT MAX(nation.nation_fk1) , lineitem.l_shipmode,orders.o_totalprice,lineitem.l_receiptdate,lineitem.tid,supplier.s_name,nation.nation_fk1 
FROM partsupp,part,lineitem,orders,customer,nation,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY lineitem.l_shipmode,orders.o_totalprice,lineitem.l_receiptdate,lineitem.tid,supplier.s_name,nation.nation_fk1  


SELECT COUNT(orders.o_comment) , AVG(partsupp.ps_suppkey) 
FROM customer,orders,lineitem,part,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY lineitem.l_linestatus,part.p_type,orders.o_orderkey,part.p_retailprice,orders.o_comment,customer.c_acctbal,partsupp.ps_suppkey


SELECT supplier.s_nationkey,partsupp.tid,nation.n_regionkey,supplier.s_acctbal,partsupp.ps_partkey 
FROM partsupp,supplier,nation 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY nation.n_name,partsupp.ps_suppkey,supplier.s_nationkey,partsupp.tid,nation.n_regionkey,supplier.s_acctbal,partsupp.ps_partkey  


SELECT customer.c_acctbal,supplier.s_address,lineitem.l_returnflag,supplier.s_phone,supplier.s_suppkey,orders.o_orderdate 
FROM orders,customer,supplier,lineitem,part,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY orders.tid,part.p_mfgr,lineitem.l_shipinstruct,customer.c_acctbal,supplier.s_address,lineitem.l_returnflag,supplier.s_phone,supplier.s_suppkey,orders.o_orderdate  


SELECT MIN(lineitem.l_shipinstruct) , part.p_size,part.p_retailprice,lineitem.l_shipinstruct,part.p_brand 
FROM orders,lineitem,part,partsupp 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY lineitem.l_orderkey,partsupp.ps_supplycost,part.p_size,part.p_retailprice,lineitem.l_shipinstruct,part.p_brand 
ORDER BY lineitem.l_shipinstruct,part.p_brand 
LIMIT 5

SELECT COUNT(nation.n_nationkey) 
FROM nation,supplier,lineitem,partsupp,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY nation.n_name,lineitem.tid,supplier.s_suppkey,supplier.s_name,lineitem.l_suppkey,nation.n_nationkey


SELECT lineitem.l_discount,lineitem.l_shipinstruct 
FROM lineitem,partsupp,supplier 
WHERE partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY lineitem.l_receiptdate,partsupp.ps_availqty,lineitem.l_discount,lineitem.l_shipinstruct 
ORDER BY lineitem.l_discount  


SELECT nation.n_nationkey 
FROM region,nation,customer,supplier,partsupp,part,lineitem,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND nation.n_nationkey >= 4 
GROUP BY nation.tid,customer.c_mktsegment,nation.n_nationkey


SELECT MAX(customer.c_nationkey) , SUM(nation.n_regionkey) , MAX(region.r_regionkey) , COUNT(region.r_regionkey) , nation.n_comment,nation.n_regionkey,region.r_regionkey,customer.c_nationkey 
FROM region,nation,supplier,customer 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_comment,customer.c_acctbal,supplier.s_name,nation.n_comment,nation.n_regionkey,region.r_regionkey,customer.c_nationkey


SELECT COUNT(nation.nation_fk1) , COUNT(customer.c_comment) , MAX(customer.c_comment) , MAX(customer.c_nationkey) 
FROM supplier,customer,nation 
WHERE customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY supplier.s_acctbal,customer.c_mktsegment,customer.c_comment,nation.tid,supplier.s_name,nation.nation_fk1,customer.c_nationkey


SELECT nation.tid,lineitem.tid,lineitem.l_returnflag,partsupp.tid,supplier.s_suppkey 
FROM lineitem,part,partsupp,supplier,nation,customer 
WHERE lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND lineitem.l_returnflag LIKE 'N' 
GROUP BY supplier.s_name,nation.tid,lineitem.tid,lineitem.l_returnflag,partsupp.tid,supplier.s_suppkey


SELECT orders.o_custkey,lineitem.l_suppkey,supplier.s_phone,supplier.tid,orders.o_shippriority 
FROM region,nation,customer,supplier,lineitem,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey <= 1 
GROUP BY orders.o_clerk,region.r_regionkey,lineitem.l_linestatus,orders.o_custkey,lineitem.l_suppkey,supplier.s_phone,supplier.tid,orders.o_shippriority 
ORDER BY orders.o_custkey,lineitem.l_suppkey,supplier.tid 
LIMIT 5

SELECT MAX(partsupp.tid) , SUM(partsupp.tid) , SUM(lineitem.l_orderkey) , AVG(part.p_retailprice) , AVG(partsupp.tid) 
FROM part,lineitem,supplier,partsupp 
WHERE lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY lineitem.l_suppkey,part.p_retailprice,lineitem.l_orderkey,partsupp.tid,supplier.s_phone,lineitem.l_receiptdate


SELECT MAX(lineitem.l_comment) , lineitem.l_comment,customer.c_phone 
FROM region,nation,customer,supplier,lineitem,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY lineitem.l_commitdate,region.tid,lineitem.l_tax,lineitem.l_comment,customer.c_phone  


SELECT partsupp.ps_availqty,lineitem.l_linestatus,lineitem.l_discount,lineitem.l_extendedprice 
FROM lineitem,supplier,partsupp,part 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey AND lineitem.l_discount <= 0.090000 
GROUP BY partsupp.ps_supplycost,lineitem.l_receiptdate,part.p_type,partsupp.ps_availqty,lineitem.l_linestatus,lineitem.l_discount,lineitem.l_extendedprice


SELECT supplier.tid,lineitem.l_suppkey,lineitem.l_partkey,partsupp.ps_partkey 
FROM customer,orders,lineitem,partsupp,supplier 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY orders.o_orderstatus,lineitem.l_shipmode,supplier.s_address,supplier.tid,lineitem.l_suppkey,lineitem.l_partkey,partsupp.ps_partkey


SELECT MIN(nation.tid) , nation.tid 
FROM region,nation,supplier,lineitem,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND nation.tid > 4 
GROUP BY supplier.s_address,nation.tid  


SELECT AVG(nation.nation_fk1) , part.p_partkey,nation.nation_fk1,part.p_name,supplier.tid,supplier.s_nationkey 
FROM nation,supplier,partsupp,lineitem,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_partkey = part.p_partkey AND supplier.tid < 3 
GROUP BY lineitem.l_orderkey,supplier.s_comment,part.p_partkey,nation.nation_fk1,part.p_name,supplier.tid,supplier.s_nationkey  


SELECT MIN(customer.c_acctbal) , lineitem.l_orderkey,customer.c_acctbal,lineitem.l_partkey,lineitem.l_shipmode,part.p_container 
FROM part,lineitem,supplier,nation,customer 
WHERE lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY customer.c_comment,lineitem.l_receiptdate,lineitem.l_shipinstruct,lineitem.l_orderkey,customer.c_acctbal,lineitem.l_partkey,lineitem.l_shipmode,part.p_container 
ORDER BY lineitem.l_partkey,lineitem.l_shipmode,part.p_container  


SELECT MIN(partsupp.ps_comment) , COUNT(supplier.s_comment) , COUNT(partsupp.ps_comment) 
FROM region,nation,supplier,partsupp 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY supplier.s_suppkey,region.tid,supplier.s_address,partsupp.ps_comment,supplier.s_comment


SELECT MAX(nation.n_regionkey) , SUM(nation.n_regionkey) 
FROM nation,customer,supplier,lineitem,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey 
GROUP BY customer.c_mktsegment,customer.c_custkey,partsupp.ps_suppkey,nation.n_regionkey,nation.nation_fk1


SELECT AVG(lineitem.l_suppkey) , orders.o_shippriority,lineitem.l_suppkey,lineitem.l_shipdate,lineitem.tid 
FROM part,partsupp,supplier,lineitem,orders,customer 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND lineitem.l_shipdate = date '1996-03-30' 
GROUP BY orders.o_shippriority,lineitem.l_suppkey,lineitem.l_shipdate,lineitem.tid  


SELECT customer.c_address,partsupp.ps_comment,region.r_regionkey 
FROM region,nation,customer,supplier,partsupp 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY nation.n_nationkey,customer.c_mktsegment,customer.c_address,partsupp.ps_comment,region.r_regionkey  


SELECT MAX(supplier.s_comment) , MIN(supplier.s_comment) , MAX(supplier.s_comment) 
FROM nation,customer,supplier 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_comment = 'blithely silent requests after the express dependencies are sl' 
GROUP BY supplier.s_comment


SELECT AVG(customer.c_nationkey) , region.r_regionkey,lineitem.l_linenumber,supplier.s_nationkey,customer.c_nationkey,customer.c_address 
FROM region,nation,customer,orders,lineitem,part,partsupp,supplier 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_linenumber >= 1 
GROUP BY orders.o_orderkey,orders.o_custkey,lineitem.l_shipinstruct,region.r_regionkey,lineitem.l_linenumber,supplier.s_nationkey,customer.c_nationkey,customer.c_address  


SELECT lineitem.l_orderkey 
FROM partsupp,part,lineitem,orders,customer 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND lineitem.l_orderkey = 1 
GROUP BY lineitem.l_orderkey 
ORDER BY lineitem.l_orderkey 
LIMIT 5

SELECT customer.c_name,orders.o_orderdate,partsupp.ps_availqty,orders.o_comment,orders.o_custkey 
FROM orders,customer,nation,supplier,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY customer.c_address,orders.tid,supplier.s_suppkey,customer.c_name,orders.o_orderdate,partsupp.ps_availqty,orders.o_comment,orders.o_custkey


SELECT MAX(orders.o_orderdate) , orders.o_orderdate,lineitem.l_suppkey 
FROM nation,supplier,customer,orders,lineitem,part,partsupp 
WHERE nation.n_nationkey = supplier.s_nationkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY orders.o_orderdate,lineitem.l_suppkey  


SELECT lineitem.l_shipinstruct,customer.c_comment,partsupp.ps_suppkey,supplier.s_address,lineitem.tid 
FROM customer,supplier,partsupp,lineitem 
WHERE customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey 
GROUP BY lineitem.l_comment,supplier.s_phone,supplier.s_nationkey,lineitem.l_shipinstruct,customer.c_comment,partsupp.ps_suppkey,supplier.s_address,lineitem.tid 
ORDER BY lineitem.l_shipinstruct,customer.c_comment,lineitem.tid  


SELECT MIN(partsupp.ps_availqty) , supplier.s_comment,lineitem.l_commitdate,orders.o_orderpriority,partsupp.ps_availqty 
FROM orders,lineitem,part,partsupp,supplier,customer 
WHERE orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey 
GROUP BY customer.c_comment,partsupp.ps_supplycost,supplier.s_comment,lineitem.l_commitdate,orders.o_orderpriority,partsupp.ps_availqty


SELECT MAX(nation.nation_fk1) , nation.n_nationkey,customer.c_name,nation.n_name,customer.c_address,supplier.s_acctbal,nation.nation_fk1 
FROM partsupp,supplier,nation,customer 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = 2 
GROUP BY nation.n_comment,customer.c_acctbal,nation.n_nationkey,customer.c_name,nation.n_name,customer.c_address,supplier.s_acctbal,nation.nation_fk1


SELECT MAX(part.p_type) , MAX(supplier.s_comment) 
FROM partsupp,part,lineitem,supplier,nation 
WHERE part.p_partkey = partsupp.ps_partkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY lineitem.l_extendedprice,nation.nation_fk1,supplier.s_comment,partsupp.ps_availqty,part.p_type,lineitem.l_receiptdate,supplier.s_address,lineitem.l_linestatus


SELECT supplier.s_address,partsupp.ps_supplycost,lineitem.l_returnflag,partsupp.tid,orders.o_orderpriority,partsupp.ps_availqty 
FROM supplier,partsupp,lineitem,orders 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY orders.o_custkey,orders.o_totalprice,supplier.s_address,partsupp.ps_supplycost,lineitem.l_returnflag,partsupp.tid,orders.o_orderpriority,partsupp.ps_availqty


SELECT MAX(lineitem.l_quantity) , lineitem.l_quantity,customer.c_acctbal 
FROM customer,nation,supplier,lineitem 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_quantity = 17.000000 
GROUP BY customer.tid,lineitem.l_shipmode,customer.c_phone,lineitem.l_quantity,customer.c_acctbal


SELECT MAX(orders.o_orderstatus) , orders.o_orderstatus,orders.o_totalprice,orders.o_orderdate,orders.o_custkey,orders.tid 
FROM orders  
GROUP BY orders.o_orderstatus,orders.o_totalprice,orders.o_orderdate,orders.o_custkey,orders.tid  


SELECT part.p_mfgr,lineitem.l_discount,partsupp.ps_suppkey,lineitem.l_linestatus,nation.tid,customer.c_nationkey 
FROM region,nation,customer,supplier,partsupp,lineitem,part 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_partkey = part.p_partkey AND lineitem.l_discount = 0.090000 AND lineitem.l_linestatus LIKE 'O' 
GROUP BY partsupp.tid,customer.c_phone,part.p_mfgr,lineitem.l_discount,partsupp.ps_suppkey,lineitem.l_linestatus,nation.tid,customer.c_nationkey


SELECT supplier.s_suppkey 
FROM orders,customer,supplier,lineitem,part,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY part.p_mfgr,lineitem.l_linenumber,part.p_partkey,supplier.s_suppkey  


SELECT MAX(supplier.s_nationkey) , orders.tid,supplier.s_nationkey,lineitem.l_discount,lineitem.l_shipdate,supplier.s_address 
FROM partsupp,supplier,customer,orders,lineitem 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY orders.o_clerk,lineitem.l_orderkey,orders.tid,supplier.s_nationkey,lineitem.l_discount,lineitem.l_shipdate,supplier.s_address  


SELECT SUM(lineitem.l_linenumber) , lineitem.l_linenumber,lineitem.l_returnflag,customer.c_mktsegment,lineitem.l_commitdate,orders.o_shippriority,lineitem.l_quantity 
FROM partsupp,lineitem,orders,customer,nation 
WHERE partsupp.ps_partkey = lineitem.l_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND lineitem.l_linenumber > 3 AND orders.o_shippriority = 0 
GROUP BY orders.o_orderkey,lineitem.l_linenumber,lineitem.l_returnflag,customer.c_mktsegment,lineitem.l_commitdate,orders.o_shippriority,lineitem.l_quantity 
ORDER BY lineitem.l_commitdate,orders.o_shippriority,lineitem.l_quantity 
LIMIT 4

SELECT MAX(customer.c_custkey) , customer.c_phone,supplier.s_nationkey,supplier.s_phone,customer.c_custkey,partsupp.ps_comment,customer.c_comment 
FROM customer,nation,supplier,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY customer.c_phone,supplier.s_nationkey,supplier.s_phone,customer.c_custkey,partsupp.ps_comment,customer.c_comment  


SELECT MAX(part.p_retailprice) , supplier.s_address,part.p_retailprice 
FROM part,partsupp,supplier,nation,region 
WHERE part.p_partkey = partsupp.ps_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY supplier.s_phone,supplier.s_address,part.p_retailprice  


SELECT lineitem.l_suppkey 
FROM partsupp,supplier,nation,customer,orders,lineitem,part 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY orders.o_clerk,lineitem.l_suppkey


SELECT COUNT(lineitem.l_linestatus) , lineitem.l_suppkey,partsupp.ps_suppkey,lineitem.l_linestatus 
FROM lineitem,partsupp,supplier,nation,region 
WHERE partsupp.ps_partkey = lineitem.l_partkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey AND lineitem.l_linestatus = 'O' 
GROUP BY lineitem.l_suppkey,partsupp.ps_suppkey,lineitem.l_linestatus  


SELECT AVG(supplier.tid) , supplier.tid 
FROM supplier,nation 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.tid >= 5 
GROUP BY nation.n_nationkey,supplier.s_name,supplier.tid


SELECT MIN(lineitem.l_receiptdate) , lineitem.l_receiptdate 
FROM region,nation,supplier,lineitem,orders 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey 
GROUP BY orders.tid,nation.n_comment,lineitem.l_receiptdate  


SELECT AVG(orders.o_totalprice) , region.tid,orders.o_orderstatus,orders.o_totalprice,region.r_comment 
FROM lineitem,orders,customer,supplier,nation,region 
WHERE orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY lineitem.l_linestatus,region.tid,orders.o_orderstatus,orders.o_totalprice,region.r_comment 
ORDER BY region.tid,orders.o_orderstatus 
LIMIT 5

SELECT supplier.s_suppkey,lineitem.l_extendedprice,nation.n_regionkey 
FROM nation,customer,orders,lineitem,supplier,partsupp,part 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey = supplier.s_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY lineitem.l_suppkey,customer.c_comment,supplier.s_suppkey,lineitem.l_extendedprice,nation.n_regionkey


SELECT nation.tid,supplier.s_acctbal,nation.n_regionkey,nation.n_comment 
FROM supplier,nation 
WHERE nation.n_nationkey = supplier.s_nationkey 
GROUP BY nation.n_name,supplier.s_name,supplier.s_address,nation.tid,supplier.s_acctbal,nation.n_regionkey,nation.n_comment  


SELECT part.p_comment,lineitem.l_extendedprice 
FROM nation,supplier,lineitem,part 
WHERE nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY lineitem.l_partkey,part.p_name,part.p_container,part.p_comment,lineitem.l_extendedprice  


SELECT SUM(supplier.s_acctbal) , MIN(supplier.s_acctbal) 
FROM lineitem,supplier,customer,orders 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey AND supplier.s_acctbal = 5755.940000 
GROUP BY supplier.s_acctbal


SELECT MAX(customer.c_name) , lineitem.l_suppkey,customer.c_mktsegment,customer.c_name,lineitem.tid,lineitem.l_quantity 
FROM supplier,lineitem,orders,customer 
WHERE lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND lineitem.l_quantity > 24.000000 
GROUP BY supplier.s_name,customer.c_address,supplier.s_nationkey,lineitem.l_suppkey,customer.c_mktsegment,customer.c_name,lineitem.tid,lineitem.l_quantity  


SELECT COUNT(region.r_name) , supplier.s_name,region.r_name,orders.o_orderpriority,lineitem.l_partkey 
FROM region,nation,supplier,lineitem,orders,customer 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey 
GROUP BY orders.o_orderdate,orders.o_custkey,orders.o_shippriority,supplier.s_name,region.r_name,orders.o_orderpriority,lineitem.l_partkey  


SELECT MAX(lineitem.l_linestatus) , orders.o_shippriority,lineitem.l_linestatus,lineitem.l_shipdate,lineitem.l_shipmode,partsupp.ps_partkey,lineitem.l_shipinstruct 
FROM partsupp,lineitem,orders 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_shipdate = date '1996-01-29' AND orders.o_shippriority <= 0 AND partsupp.ps_partkey <= 1 
GROUP BY lineitem.l_commitdate,partsupp.ps_supplycost,lineitem.l_discount,orders.o_shippriority,lineitem.l_linestatus,lineitem.l_shipdate,lineitem.l_shipmode,partsupp.ps_partkey,lineitem.l_shipinstruct 
ORDER BY lineitem.l_shipdate,partsupp.ps_partkey,lineitem.l_shipinstruct  


SELECT MIN(lineitem.tid) , lineitem.tid 
FROM nation,supplier,partsupp,lineitem 
WHERE nation.n_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_partkey = lineitem.l_partkey AND lineitem.tid > 1 
GROUP BY lineitem.tid


SELECT supplier.s_nationkey,partsupp.ps_comment,supplier.tid 
FROM part,partsupp,lineitem,orders,customer,supplier 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND partsupp.ps_comment = 'ven ideas. quickly even packages print. pending multipliers must have to are fluff' AND partsupp.ps_comment = 'ven ideas. quickly even packages print. pending multipliers must have to are fluff' 
GROUP BY lineitem.l_commitdate,orders.o_orderstatus,supplier.s_nationkey,partsupp.ps_comment,supplier.tid  


SELECT MAX(customer.c_name) , partsupp.ps_availqty,orders.o_custkey,lineitem.l_returnflag,customer.c_name 
FROM customer,orders,lineitem,part,partsupp 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey AND part.p_partkey = partsupp.ps_partkey 
GROUP BY part.tid,orders.tid,lineitem.l_receiptdate,partsupp.ps_availqty,orders.o_custkey,lineitem.l_returnflag,customer.c_name 
ORDER BY orders.o_custkey,lineitem.l_returnflag,customer.c_name 
LIMIT 4

SELECT MAX(nation.n_name) , customer.tid,nation.n_regionkey,customer.c_nationkey,nation.n_name 
FROM nation,customer,supplier,partsupp 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey 
GROUP BY nation.nation_fk1,customer.tid,nation.n_regionkey,customer.c_nationkey,nation.n_name  


SELECT MIN(partsupp.ps_comment) , AVG(orders.o_shippriority) , AVG(orders.o_shippriority) , AVG(orders.o_totalprice) 
FROM partsupp,lineitem,supplier,customer,orders 
WHERE partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND customer.c_nationkey = supplier.s_nationkey AND customer.c_custkey = orders.o_custkey 
GROUP BY lineitem.l_discount,orders.o_orderpriority,lineitem.l_quantity,lineitem.l_linestatus,customer.c_custkey,partsupp.ps_comment,supplier.s_acctbal,orders.o_shippriority,orders.o_totalprice


SELECT lineitem.l_suppkey,customer.tid,orders.o_shippriority,nation.n_name 
FROM part,lineitem,orders,customer,nation,region 
WHERE lineitem.l_partkey = part.p_partkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY lineitem.l_suppkey,customer.tid,orders.o_shippriority,nation.n_name 
ORDER BY lineitem.l_suppkey 
LIMIT 5

SELECT MAX(supplier.s_acctbal) 
FROM orders,customer,supplier,nation,region 
WHERE customer.c_custkey = orders.o_custkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey 
GROUP BY customer.c_comment,orders.o_comment,customer.c_phone,region.r_name,supplier.s_acctbal,orders.o_custkey


SELECT COUNT(supplier.tid) , nation.n_comment,customer.c_nationkey,supplier.s_acctbal,supplier.tid,customer.c_phone 
FROM region,nation,customer,supplier,partsupp 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND customer.c_nationkey < 2 
GROUP BY nation.n_comment,customer.c_nationkey,supplier.s_acctbal,supplier.tid,customer.c_phone  


SELECT supplier.s_acctbal,supplier.s_nationkey,region.tid 
FROM partsupp,supplier,nation,region 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey AND region.r_regionkey = nation.n_regionkey AND supplier.s_nationkey >= 0 AND region.tid = 5 
GROUP BY region.r_comment,supplier.s_comment,supplier.s_acctbal,supplier.s_nationkey,region.tid 
ORDER BY supplier.s_acctbal,region.tid 
LIMIT 4

SELECT MIN(lineitem.l_linenumber) , MIN(lineitem.l_linenumber) , SUM(supplier.s_acctbal) 
FROM customer,orders,lineitem,supplier,nation 
WHERE customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_suppkey = supplier.s_suppkey AND nation.n_nationkey = supplier.s_nationkey AND lineitem.l_discount >= 0.100000 
GROUP BY orders.o_orderstatus,supplier.s_comment,lineitem.l_orderkey,supplier.s_acctbal,orders.o_custkey,lineitem.l_linenumber,lineitem.l_discount,lineitem.l_suppkey


SELECT SUM(region.r_regionkey) , SUM(nation.n_regionkey) 
FROM region,nation,customer,supplier,partsupp,lineitem 
WHERE region.r_regionkey = nation.n_regionkey AND nation.n_nationkey = customer.c_nationkey AND customer.c_nationkey = supplier.s_nationkey AND supplier.s_suppkey = partsupp.ps_suppkey AND partsupp.ps_partkey = lineitem.l_partkey 
GROUP BY customer.c_custkey,nation.n_comment,supplier.s_suppkey,supplier.tid,nation.n_regionkey,supplier.s_nationkey,region.r_regionkey,customer.c_name


SELECT SUM(lineitem.l_orderkey) , AVG(lineitem.l_discount) , AVG(lineitem.l_discount) 
FROM orders,lineitem,partsupp,supplier,nation 
WHERE orders.o_orderkey = lineitem.l_orderkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND supplier.s_suppkey = partsupp.ps_suppkey AND nation.n_nationkey = supplier.s_nationkey 
GROUP BY lineitem.l_comment,partsupp.tid,partsupp.ps_suppkey,lineitem.l_orderkey,lineitem.l_discount,lineitem.l_receiptdate,lineitem.l_shipmode


SELECT lineitem.l_tax,lineitem.l_linestatus,part.p_brand,orders.o_orderkey,lineitem.l_suppkey,nation.tid 
FROM nation,customer,orders,lineitem,part 
WHERE nation.n_nationkey = customer.c_nationkey AND customer.c_custkey = orders.o_custkey AND orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_partkey = part.p_partkey 
GROUP BY customer.c_comment,lineitem.l_tax,lineitem.l_linestatus,part.p_brand,orders.o_orderkey,lineitem.l_suppkey,nation.tid 
ORDER BY lineitem.l_tax,lineitem.l_linestatus,lineitem.l_suppkey  


SELECT AVG(lineitem.l_partkey) , nation.n_name,lineitem.l_partkey 
FROM part,partsupp,lineitem,supplier,customer,nation 
WHERE part.p_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND customer.c_nationkey = supplier.s_nationkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY lineitem.l_orderkey,nation.n_nationkey,customer.c_nationkey,nation.n_name,lineitem.l_partkey  


SELECT COUNT(lineitem.l_quantity) , COUNT(lineitem.l_extendedprice) 
FROM customer,supplier,lineitem 
WHERE customer.c_nationkey = supplier.s_nationkey AND lineitem.l_suppkey = supplier.s_suppkey 
GROUP BY customer.c_nationkey,customer.c_mktsegment,lineitem.l_quantity,customer.c_comment,lineitem.l_extendedprice


SELECT customer.c_name,nation.tid,lineitem.tid 
FROM partsupp,supplier,lineitem,orders,customer,nation 
WHERE supplier.s_suppkey = partsupp.ps_suppkey AND lineitem.l_suppkey = supplier.s_suppkey AND orders.o_orderkey = lineitem.l_orderkey AND customer.c_custkey = orders.o_custkey AND nation.n_nationkey = customer.c_nationkey 
GROUP BY partsupp.ps_suppkey,customer.c_name,nation.tid,lineitem.tid


