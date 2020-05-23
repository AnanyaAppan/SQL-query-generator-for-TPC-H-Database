from read_schema import get_data
from utils import *
import random
import nltk
from nltk.parse.generate import generate
import psycopg2
import psycopg2.extras
import re

def main() :
    f = open("queries1.txt","a")
    table_dict, foreign_key_dict, G = get_data()
    count = 0
    all_simple_paths = get_all_simple_paths(G)
    conn = psycopg2.connect("dbname=tpch host='localhost' user='ananya' password='*Rasika0507'")
    while(count < 100) :

        choice = random.choice(all_simple_paths)
        path = get_random_sublist(choice,2,len(choice))
        tables = get_tables_from_path(path)
        min_rows = get_min_rows(conn,table_dict)
        columns = get_columns_from_tables(tables,table_dict)
        chosen_columns = get_random_sublist(columns,1,10)
        all_combinations = get_all_combinations(chosen_columns)
        all_combinations_str = get_pipe_separated([get_comma_separated(cols) for cols in all_combinations])
        filters = []
        aggregations = []
        limit_str = get_pipe_separated(range(3,min_rows+1))

        for col in chosen_columns:
            alist , flist = get_agg_filters_for_col(conn,col,table_dict)
            filters += flist
            aggregations += alist

        grammar_string = """
            S -> 'SELECT' COLS "FROM" TABLES COND_CLAUSE GROUP_BY_CLAUSE ORDER_BY_CLAUSE LIMIT_CLAUSE ';'
            COLS -> AGG_COLS ',' PROJ_COLS | AGG_COLS | PROJ_COLS | '*' 
            AGG_COLS -> AGG ',' AGG_COLS | AGG 
            ORDER_BY_CLAUSE -> "ORDER BY" ORDER_COLS | " " 
            GROUP_BY_CLAUSE -> "GROUP BY" GROUP_COLS | " " 
            COND_CLAUSE -> "WHERE" JOIN_COND | "WHERE" FILTER_COND | "WHERE" JOIN_COND 'AND' FILTER_CLAUSE | " " 
            FILTER_CLAUSE -> FILTER_CLAUSE 'AND' FILTER_COND | FILTER_COND 
            LIMIT_CLAUSE -> "LIMIT" NUM_ROWS | " "
            AGG -> %s
            NUM_ROWS -> %s
            FILTER_COND -> %s
            JOIN_COND -> %s
            TABLES -> %s
            ORDER_COLS -> %s
            GROUP_COLS -> %s  
            PROJ_COLS -> %s
        """ % (get_pipe_separated(aggregations),limit_str,get_pipe_separated(filters),
                get_join_condition(path), enclose_with_quotes(get_comma_separated(tables)), 
                all_combinations_str, all_combinations_str, enclose_with_quotes(get_comma_separated(chosen_columns))
            )
        grammar = nltk.CFG.fromstring(grammar_string)
        res = generate(grammar, depth=4)
        for sentence in res:
            query = ' '.join(sentence)
            query = "\nFROM".join(query.split('FROM'))
            if(re.search('WHERE',query)) : query = "\nWHERE".join(query.split('WHERE'))
            if(re.search('ORDER BY',query)) : query = "\nORDER BY".join(query.split('ORDER BY'))
            if(re.search('GROUP BY',query)) : query = "\nGROUP BY".join(query.split('GROUP BY'))
            if(re.search('LIMIT',query)) : query = "\nLIMIT".join(query.split('LIMIT'))
            query += '\n\n'
            if(random.choice(range(1,3000))%200 == 0): f.write(query)
        count += 1
    f.close()

main()
