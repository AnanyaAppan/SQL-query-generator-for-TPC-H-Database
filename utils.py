import psycopg2
import psycopg2.extras
import networkx as nx
import random
from itertools import combinations

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

def get_foreign_key_dict(connection, tables):
    """
    Creates and returns a dictionary with the table names
    as keys, and the list of dictionaries returned by get_foreign_key 
    as the corresponding values
    """
    d = {}
    for row in tables :
        d[row["table_name"]] = get_foreign_key(connection,row["table_name"])
    return d

def print_tables(tables):
    """
    Prints the list created by get_tables
    """

    for row in tables:

        print("{}.{}".format(row["table_schema"], row["table_name"])) 

def get_foreign_key(conn,table_name) :
    """
    Given a table name, returns a list of dictionaries.
    Each dictionary in the list has a foreign key of the
    specified table, and the primary key it references.
    """
    cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    where_dict = {"table_name": table_name}
    cursor.execute("""SELECT 
                            kcu.column_name, 
                            ccu.column_name AS foreign_column_name ,
                            ccu.table_name AS foreign_table_name
                        FROM 
                            information_schema.table_constraints AS tc 
                            JOIN information_schema.key_column_usage AS kcu
                            ON tc.constraint_name = kcu.constraint_name
                            AND tc.table_schema = kcu.table_schema
                            JOIN information_schema.constraint_column_usage AS ccu
                            ON ccu.constraint_name = tc.constraint_name
                            AND ccu.table_schema = tc.table_schema
                        WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_name=%(table_name)s;
                        """, where_dict
                    )
    columns = cursor.fetchall()
    return columns


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

def get_join_graph(foreign_key_dict):
    """
    Returns the join garph of the given foreign_key_dictionary
    """
    G = nx.Graph()
    for table in foreign_key_dict:
        references = foreign_key_dict[table]
        for reference in references :
            col_name = table + "." + reference["column_name"]
            foreign_col_name = reference["foreign_table_name"] + "." + reference["foreign_column_name"]
            G.add_node(col_name)
            G.add_node(foreign_col_name)
            G.add_edge(col_name, foreign_col_name)
    return G

def get_all_simple_paths(G) :
    """
    Returns all possible simple paths in a graph G
    """
    simple_paths = []
    for src in G.nodes() :
        for dest in G.nodes() :
            paths = list(nx.all_simple_paths(G,src,dest))
            for path in paths : 
                if path not in simple_paths and len(path)!=0 : simple_paths.append(path)
    return simple_paths

def get_tables_from_path (path) :
    """
    returns a list of tables given the corrsponding path 
    in the join graph
    """
    tables = []
    for col in path :
        table_name = col.split(".")[0]
        if(table_name not in tables) : tables.append(table_name)
    return tables

def get_join_condition (path) :
    """
    return the join condition as a string given the 
    corrsponding path in the join graph
    """
    if(len(path) == 1) : return ""
    join_condition = path[0] + " = " + path[1]
    for i in range(2,len(path)) :
        prev_col = path[i-1]
        col = path[i]
        join_condition += " AND " + prev_col + " = " + col
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
    return "\'" + string + "\'"

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

        