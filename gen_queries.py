from read_schema import get_data
from utils import *
import random
import nltk
from nltk.parse.generate import generate
import psycopg2
import psycopg2.extras
import re
import itertools
import more_itertools
import pandas as pd

def generate_sample(grammar, prod, frags):        
    if prod in grammar._lhs_index: # Derivation
        derivations = grammar._lhs_index[prod]            
        derivation = random.choice(derivations)            
        for d in derivation._rhs:            
            generate_sample(grammar, d, frags)
    elif prod in grammar._rhs_index:
        # terminal
        frags.append(str(prod))

def main() :
    f = open("queries3.txt","a")
    table_dict, G = get_data()
    count = 0
    all_simple_paths = get_all_simple_paths(G)
    conn = psycopg2.connect("dbname=tpch3 host='localhost' user='ananya' password='*Rasika0507'")
    while(count < 100) :
        path = random.choice(all_simple_paths)
        if ('lineitem' in path or 'orders' in path) and len(path) > 4 :
            path = path[:4]
        # path = get_random_sublist(choice,2,len(choice))
        tables = get_tables_from_path(path)
        max_rows = get_max_rows(conn,table_dict) 
        chosen_columns = []
        filters = []
        while(not len(chosen_columns) or not len(filters)) : 
            columns = get_columns_from_tables(tables,table_dict)
            chosen_columns = get_random_sublist(columns,1,6)
            chosen_columns = remove_key_attributes_from_cols_list(conn,chosen_columns)
            filters = []
            aggregations = []
            for col in chosen_columns:
                alist , flist = get_agg_filters_for_col(conn,col,table_dict)
                filters += flist
                aggregations += alist

        other_columns = list(set(columns) - set(chosen_columns))
        group_by_cols = get_comma_separated(get_random_sublist(other_columns,0,3))
        if(group_by_cols != ""):
            group_by_cols = "'" + group_by_cols + "," + get_comma_separated(chosen_columns) + "'"
        else :
            group_by_cols = "'" + get_comma_separated(chosen_columns) + "'"
        all_combinations = get_all_combinations(chosen_columns)
        all_combinations_str = get_pipe_separated([get_comma_separated(cols) for cols in all_combinations])
        limit_str = str(random.choice(range(3,max_rows+1)))
        join_condition = get_join_condition(path,G)

        grammar_string = """
            S -> 'SELECT' COLS_ORDER_BY FROM_CLAUSE COND_CLAUSE GROUP_BY_CLAUSE ORDER_BY_CLAUSE LIMIT_CLAUSE ';'
            FROM_CLAUSE -> 'FROM' TABLES
            COLS -> AGG_COLS  COMMA_SEPARATOR_PROJ | AGG_COLS | PROJ_COLS  
            COLS_ORDER_BY -> AGG COMMA_SEPARATOR_PROJ | PROJ_COLS
            COMMA_SEPARATOR_PROJ -> ',' PROJ_COLS
            AGG_COLS -> AGG COMMA_SEPARATOR_AGG | AGG 
            COMMA_SEPARATOR_AGG ->  ',' AGG_COLS
            ORDER_BY_CLAUSE -> 'ORDER BY' ORDER_COLS | " " 
            GROUP_BY_CLAUSE -> 'GROUP BY' GROUP_COLS 
            COND_CLAUSE -> 'WHERE' JOIN_COND | 'WHERE' JOIN_COND FILTER_CLAUSE 
            FILTER_CLAUSE -> 'AND' FILTER_COND FILTER_CLAUSE | 'AND' FILTER_COND 
            LIMIT_CLAUSE -> 'LIMIT' NUM_ROWS | " "
            AGG -> %s
            NUM_ROWS -> %s
            FILTER_COND -> %s
            JOIN_COND -> %s
            TABLES -> %s
            ORDER_COLS -> %s
            GROUP_COLS -> %s  
            PROJ_COLS -> %s
        """ % (get_pipe_separated(aggregations),limit_str,get_pipe_separated(filters),
                join_condition, enclose_with_quotes(get_comma_separated(tables)), 
                all_combinations_str, group_by_cols, enclose_with_quotes(get_comma_separated(chosen_columns))
            )
        grammar = nltk.CFG.fromstring(grammar_string)
        # res = generate(grammar, depth=4)
        sentence = []  
        generate_sample(grammar, grammar.start(), sentence)
        if(join_condition == "") :
            where_index = sentence.index('WHERE')
            if(where_index == len(sentence)-1): sentence[where_index] = ''
            elif (sentence[where_index+1][0] != 'A'): sentence[where_index] = ''
            else : sentence[where_index+1] = sentence[where_index+1].strip('AND')
        query = ' '.join(sentence)
        query = "\nFROM".join(query.split('FROM'))
        if(re.search('WHERE',query)) : query = "\nWHERE".join(query.split('WHERE'))
        if(re.search('ORDER BY',query)) : query = "\nORDER BY".join(query.split('ORDER BY'))
        if(re.search('GROUP BY',query)) : query = "\nGROUP BY".join(query.split('GROUP BY'))
        if(re.search('LIMIT',query)) : 
            query = "\nLIMIT".join(query.split('LIMIT'))
        query += '\n\n'
        print(query)
        df = pd.read_sql_query(query , conn)
        if len(df.index) > 0 :
            f.write(query)
        print("executed query")
        count += 1
    f.close()

main()


