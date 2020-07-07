import psycopg2
import psycopg2.extras
from utils import get_tables,get_table_dict,get_foreign_key_dict,get_join_graph
import networkx as nx
import matplotlib.pyplot as plt

def get_data ():
    """
    Reads schema of the specified database and returns 
    1) table_dict : A dictionary which maps table names to a dictionary of columns,
        where each column dictionary maps column names to column attributes
    2) G : The join graph 
    """
    try:
        conn = psycopg2.connect("dbname=tpch3 host='localhost' user='ananya' password='*Rasika0507'")
        tables = get_tables(conn)
        table_dict = get_table_dict(conn,tables)
        G = get_join_graph(conn)
        # nx.draw(G)
        # plt.show()

    except psycopg2.Error as e:
        print(type(e))
        print(e)

    return table_dict, G
