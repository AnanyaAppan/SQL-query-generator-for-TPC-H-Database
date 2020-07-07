import psycopg2
import psycopg2.extras
import networkx as nx
import random
from itertools import combinations
from datetime import date
from decimal import *
import matplotlib.pyplot as plt

def get_tables(connection):
    """
    Create and return a list of dictionaries with the
    schemas and names of tables in the database
    connected to by the connection argument.
    """

    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

    cursor.execute("""SELECT table_schema, table_name
                      FROM information_schema.tables
                      WHERE table_schema != 'pg_catalog'
                      AND table_schema != 'information_schema'
                      AND table_type='BASE TABLE'
                      ORDER BY table_schema, table_name""")

    tables = cursor.fetchall()

    cursor.close()

    return tables

def get_col_values (connection,col_name,table_name) :
    """
    Gets values of a clomun, goven table and column name
    """
    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("""SELECT %s
                      FROM %s
                      """ % (col_name,table_name))
    vals = cursor.fetchall()
    cursor.close()
    ret_vals = [val[col_name] for val in vals]
    return ret_vals

def get_table_dict(connection, tables):
    """
    Creates and returns a dictionary with the table names
    as keys, and the dictionary returned by get_columns as 
    the corresponding values
    """
    d = {}
    for row in tables :
        d[row["table_name"]] = get_columns(connection, row["table_schema"], row["table_name"])
    return d

# def get_foreign_key_dict(connection, tables):
#     """
#     Creates and returns a dictionary with the table names
#     as keys, and the list of dictionaries returned by get_foreign_key 
#     as the corresponding values
#     """
#     d = {}
#     for row in tables :
#         d[row["table_name"]] = get_foreign_key(connection,row["table_name"])
#     return d

def print_tables(tables):
    """
    Prints the list created by get_tables
    """

    for row in tables:

        print("{}.{}".format(row["table_schema"], row["table_name"])) 

# def get_foreign_key(conn,table_name) :
#     """
#     Given a table name, returns a list of dictionaries.
#     Each dictionary in the list has a foreign key of the
#     specified table, and the primary key it references.
#     """
#     cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
#     where_dict = {"table_name": table_name}
#     cursor.execute("""SELECT 
#                             kcu.column_name, 
#                             ccu.column_name AS foreign_column_name ,
#                             ccu.table_name AS foreign_table_name
#                         FROM 
#                             information_schema.table_constraints AS tc 
#                             JOIN information_schema.key_column_usage AS kcu
#                             ON tc.constraint_name = kcu.constraint_name
#                             AND tc.table_schema = kcu.table_schema
#                             JOIN information_schema.constraint_column_usage AS ccu
#                             ON ccu.constraint_name = tc.constraint_name
#                             AND ccu.table_schema = tc.table_schema
#                         WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_name=%(table_name)s;
#                         """, where_dict
#                     )
#     columns = cursor.fetchall()
#     return columns


def get_columns(connection, table_schema, table_name):

    """
    Creates and returns a list of dictionaries for the specified
    schema.table in the database connected to.
    """

    where_dict = {"table_schema": table_schema, "table_name": table_name}
    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("""SELECT column_name, ordinal_position, is_nullable, data_type, character_maximum_length
                      FROM information_schema.columns
                      WHERE table_schema = %(table_schema)s
                      AND table_name   = %(table_name)s
                      ORDER BY ordinal_position""",
                      where_dict)
    columns = cursor.fetchall()
    cursor.close()
    col_dict = {}
    for col in columns:
        col_dict[col["column_name"]] = col
    return col_dict


def print_columns(columns):

    """
    Prints the list created by get_columns.
    """

    for row in columns:

        print("Column Name:              {}".format(row["column_name"]))
        print("Ordinal Position:         {}".format(row["ordinal_position"]))
        print("Is Nullable:              {}".format(row["is_nullable"]))
        print("Data Type:                {}".format(row["data_type"]))
        print("Character Maximum Length: {}\n".format(row["character_maximum_length"])) 

# def get_join_graph(foreign_key_dict):
#     """
#     Returns the join garph of the given foreign_key_dictionary
#     """
#     G = nx.Graph()
#     for table in foreign_key_dict:
#         references = foreign_key_dict[table]
#         for reference in references :
#             col_name = table + "." + reference["column_name"]
#             foreign_col_name = reference["foreign_table_name"] + "." + reference["foreign_column_name"]
#             G.add_node(col_name)
#             G.add_node(foreign_col_name)
#             G.add_edge(col_name, foreign_col_name)
#     G.remove_edge('lineitem.l_partkey','partsupp.ps_suppkey')
#     G.remove_edge('lineitem.l_suppkey','partsupp.ps_partkey')
#     return G

def get_primary_keys(connection) :
    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("""
                    select kcu.table_name,kcu.column_name as key_column
                    from information_schema.table_constraints tco
                    join information_schema.key_column_usage kcu 
                        on kcu.constraint_name = tco.constraint_name
                        and kcu.constraint_schema = tco.constraint_schema
                        and kcu.constraint_name = tco.constraint_name
                    where tco.constraint_type = 'PRIMARY KEY'
                    order by kcu.ordinal_position;
                        """)
    data = cursor.fetchall()
    cursor.close()
    ret = {}
    for row in data :
        if row['table_name'] not in ret :
            ret[row['table_name']] = [row['key_column']]
        else :
            ret[row['table_name']].append(row['key_column'])
    for table in ret :
        ret[table].sort()
    return ret

def get_foreign_keys(connection) :
    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("""
                    select kcu.table_schema || '.' ||kcu.table_name as foreign_table,
                    rel_tco.table_schema || '.' || rel_tco.table_name as primary_table,
                    string_agg(kcu.column_name, ', ') as fk_columns,
                    kcu.constraint_name
                    from information_schema.table_constraints tco
                    join information_schema.key_column_usage kcu
                            on tco.constraint_schema = kcu.constraint_schema
                            and tco.constraint_name = kcu.constraint_name
                    join information_schema.referential_constraints rco
                            on tco.constraint_schema = rco.constraint_schema
                            and tco.constraint_name = rco.constraint_name
                    join information_schema.table_constraints rel_tco
                            on rco.unique_constraint_schema = rel_tco.constraint_schema
                            and rco.unique_constraint_name = rel_tco.constraint_name
                    where tco.constraint_type = 'FOREIGN KEY'
                    group by kcu.table_schema,
                            kcu.table_name,
                            rel_tco.table_name,
                            rel_tco.table_schema,
                            kcu.constraint_name
                    order by kcu.table_schema,
                            kcu.table_name;
    """)
    columns = cursor.fetchall()
    cursor.close()
    for col in columns :
        col['fk_columns'] = col['fk_columns'].split(',')
        col['fk_columns'].sort()
        col['fk_columns'] = ','.join(col['fk_columns']).strip()
    return columns

def get_foreign_key_dict(primary_keys,foreign_keys) :
    ret_dict = {}
    for row in foreign_keys :
        table = row['foreign_table'].split(".")[1]
        primary_table = row['primary_table'].split(".")[1]
        foreign_key_cols = row['fk_columns'].split(',')
        for i in range(len(foreign_key_cols)):
            d = {}
            d["foreign_col"] = foreign_key_cols[i]
            d["primary_col"] = primary_keys[primary_table][i]
            d["primary_table"] = primary_table
            if table not in ret_dict:
                ret_dict[table] = [d]
            else :
                ret_dict[table].append(d)
    return ret_dict

def get_primary_key_dict(foregin_key_dict) :
    ret_dict = {}
    for table in foregin_key_dict :
        for constraint in foregin_key_dict[table] :
            primary_table = constraint["primary_table"]
            d = {}
            d["foreign_table"] = table
            d["foreign_col"] = constraint["foreign_col"]
            d["primary_col"] = constraint["primary_col"]
            if primary_table not in ret_dict:
                ret_dict[primary_table] = [d]
            else :
                ret_dict[primary_table].append(d)
    return ret_dict


def merge_join_graph(G):
    merged_graph = nx.MultiGraph()
    nodes = list(G.nodes())
    tables = [node.split(".")[0] for node in nodes]
    for table in tables :
        merged_graph.add_node(table)
    for table in tables :
        cols = [node for node in nodes if node.split(".")[0] == table]
        for col in cols:
            for x in G[col]:
                x_table = x.split(".")[0]
                if(not (((table,x_table) in list(merged_graph.edges())) or ((x_table,table) in list(merged_graph.edges())))):
                    index = merged_graph.add_edge(table,x_table)
                    merged_graph[table][x_table][index]['join'] = G[col][x]['join']
                else:
                    joins = [merged_graph[table][x_table][index]['join'] for index in merged_graph[table][x_table]]
                    if G[col][x]['join'] not in joins:
                        index = merged_graph.add_edge(table,x_table)
                        merged_graph[table][x_table][index]['join'] = G[col][x]['join']
    # draw_tree(merged_graph)
    return merged_graph

def get_join_graph(connection) :
    foreign_keys = get_foreign_keys(connection)
    primary_keys = get_primary_keys(connection)
    foreign_key_dict = get_foreign_key_dict(primary_keys,foreign_keys)
    primary_key_dict = get_primary_key_dict(foreign_key_dict)
    G = nx.Graph()
    for table in primary_key_dict:
        for fk_rel in primary_key_dict[table]:
            foreign_table = fk_rel['foreign_table']
            node1 = table + "." + fk_rel['primary_col']
            node2 = foreign_table + "." + fk_rel['foreign_col']
            G.add_edge(node1,node2)
            G[node1][node2]['join'] = [node1,node2] 
    nodes = list(G.nodes())
    for i in range(len(nodes)):
        for j in range(i+1,len(nodes)):
            node1 = nodes[i]
            node2 = nodes[j]
            paths = list(nx.all_simple_paths(G, source=node1, target=node2))
            for path in paths:
                if(len(path)>2):
                    G.add_edge(node1,node2)
                    G[node1][node2]['join'] = [node1,node2]
    return merge_join_graph(G)

def get_all_simple_paths(G) :
    """
    Returns all possible simple paths in a graph G
    """
    simple_paths = []
    for src in G.nodes() :
        simple_paths.append([src])
        for dest in G.nodes() :
            paths = list(nx.all_simple_paths(G,src,dest))
            for path in paths : 
                if path not in simple_paths and len(path)!=0 : simple_paths.append(path)
    return simple_paths

def get_tables_from_path (path) :
    """
    returns a list of tables given the corresponding path 
    in the join graph
    """
    tables = []
    for table_name in path :
        if(table_name not in tables) : tables.append(table_name)
    return tables

def get_join_condition (path,join_graph) :
    """
    return the join condition as a string given the 
    corrsponding path in the join graph
    """
    if(len(path) == 1) : return ""
    index = random.choice([index for index in join_graph[path[0]][path[1]]])
    join_condition = join_graph[path[0]][path[1]][index]['join'][0] + " = " + join_graph[path[0]][path[1]][index]['join'][1]
    for i in range(2,len(path)) :
        prev_col = path[i-1]
        col = path[i]
        index = random.choice([index for index in join_graph[path[i-1]][path[i]]])
        join_condition += " AND " + join_graph[path[i-1]][path[i]][index]['join'][0] + " = " + join_graph[path[i-1]][path[i]][index]['join'][1]
    return enclose_with_quotes(join_condition)

def get_columns_from_tables (tables, table_dict) :
    """
    gets all the columns present in a given 
    dictionary of tables
    """
    cols = []
    for table in tables :
        for col in table_dict[table] :
            col_name = table + "." + col
            cols.append(col_name)
    return cols

def enclose_with_quotes(string) : 
    return "\"" + str(string) + "\""

def get_comma_separated (cols) :
    string = ""
    for col in cols : 
        string += col + ","
    return string.strip(",")

def get_pipe_separated (l) :
    string = ""
    for i in l :
        string += enclose_with_quotes(i) + "|"
    return string.strip("|")

def get_random_sublist(l, min_len, max_len):
    size = random.choice(range(min_len,max_len+1))
    random.shuffle(l)
    return l[:size]

def get_all_combinations(l) :
    ret = []
    for r in range(1,len(l)+1) : 
        ret += combinations(l,r)
    return ret

def get_num_rows(conn,table) :
    cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("""SELECT count(*) FROM %s"""%table)
    res = cursor.fetchall()
    cursor.close()
    return res[0]['count']

def get_max_rows(conn,tables) :
    rows = [get_num_rows(conn,table) for table in tables.keys()]
    return max(rows)


def get_agg_filters_for_col(conn,col,table_dict) :
    table_name = col.split('.')[0]
    col_name = col.split('.')[1]
    col_vals = get_col_values(conn,col_name,table_name)
    is_nullable = table_dict[table_name][col_name]['is_nullable']
    aggregation_list = []
    filters_list = []

    aggregation_list.append("MAX(%s)"%col)
    aggregation_list.append("MIN(%s)"%col)
    aggregation_list.append("COUNT(%s)"%col)

    if(is_nullable == 'YES') : 
        filters_list.append("%s IS NOT NULL"%col)
        filters_list.append("%s IS NULL"%col)

    col_type = type(col_vals[0])
    if(col_type==int) :
        filters_list.append("%s = %d"%(col,random.choice(col_vals)))
        filters_list.append("%s >= %d"%(col,random.choice(col_vals)))
        filters_list.append("%s <= %d"%(col,random.choice(col_vals)))
        filters_list.append("%s > %d"%(col,random.choice(col_vals)))
        filters_list.append("%s < %d"%(col,random.choice(col_vals)))

    elif(col_type==Decimal) :
        pass
        # filters_list.append("%s = %lf"%(col,random.choice(col_vals)))
        # filters_list.append("%s >= %lf"%(col,random.choice(col_vals)))
        # filters_list.append("%s <= %lf"%(col,random.choice(col_vals)))
        # filters_list.append("%s > %lf"%(col,random.choice(col_vals)))
        # filters_list.append("%s < %lf"%(col,random.choice(col_vals)))
    elif(col_type==str) :
        filters_list.append("%s = '%s'"%(col,random.choice(col_vals)))
        filters_list.append("%s LIKE '%s"%(col,random.choice(col_vals)[:random.choice(range(len(random.choice(col_vals))))]) + "%'")
    elif(col_type==date) :
        filters_list.append("%s = date '%s'"%(col,random.choice(col_vals)))
    
    if(col_type == int or col_type==Decimal) :
        aggregation_list.append("AVG(%s)"%col)
        aggregation_list.append("SUM(%s)"%col)
    return aggregation_list , filters_list

def remove_key_attributes_from_cols_list(conn,cols_list) :
    foreign_keys = get_foreign_keys(conn)
    primary_keys = get_primary_keys(conn)
    foreign_key_dict = get_foreign_key_dict(primary_keys,foreign_keys)
    key_cols = set([])
    for table in foreign_key_dict :
        fk_constraints = foreign_key_dict[table]
        for constraint in fk_constraints :
            key_cols.add(table + '.' + constraint['foreign_col'])
            key_cols.add(constraint['primary_table'] + '.' + constraint['primary_col'])
    ret = []
    for col in cols_list :
        if col not in key_cols : ret.append(col)
    return ret

def draw_graph(G) :
    pos = nx.spring_layout(G)
    nx.draw(G, pos,with_labels=True)
    plt.show()


        