from read_schema import get_data
from utils import *
import random
import nltk
from nltk.parse.generate import generate


def main() :
    f = open("queries.txt","a")
    table_dict, foreign_key_dict, G = get_data()
    count = 0
    all_simple_paths = get_all_simple_paths(G)
    while(count < 1) :
        choice = random.choice(all_simple_paths)
        path = get_random_sublist(choice,2,len(choice))
        tables = get_tables_from_path(path)
        columns = get_columns_from_tables(tables,table_dict)
        chosen_columns = get_random_sublist(columns,1,10)
        all_combinations = get_all_combinations(chosen_columns)
        all_combinations_str = get_pipe_separated([get_comma_separated(cols) for cols in all_combinations])

        grammar_string = """
            S -> 'SELECT' COLS 'FROM' TABLES COND_CLAUSE ORDER_BY_CLAUSE GROUP_BY_CLAUSE
            COLS -> AGG_COLS ',' PROJ_COLS | AGG_COLS | PROJ_COLS | '*'
            AGG_COLS -> AGG ',' AGG_COLS | AGG 
            AGG -> 'MAX (' COL ')' | 'MIN (' COL ')' | 'COUNT (' COL ')' | 'SUM (' COL ')' | 'AVG (' COL ')'
            COL -> %s
            ORDER_BY_CLAUSE -> 'ORDER BY' ORDER_COLS | ' '
            GROUP_BY_CLAUSE -> 'GROUP BY' GROUP_COLS | ' '
            COND_CLAUSE -> 'WHERE' JOIN_COND | ' '
            JOIN_COND -> %s
            TABLES -> %s
            ORDER_COLS -> %s
            GROUP_COLS -> %s  
            PROJ_COLS -> %s
        """ % (get_pipe_separated(chosen_columns), get_join_condition(path), enclose_with_quotes(get_comma_separated(tables)), all_combinations_str, all_combinations_str, enclose_with_quotes(get_comma_separated(chosen_columns)))
        # print(grammar_string)
        grammar = nltk.CFG.fromstring(grammar_string)
        res = generate(grammar, depth=100)
        print(res)
        # count1 = 0
        for sentence in res:
            query = ' '.join(sentence) + "\n"
            # f.write(query)
            print(query)
            # count1 += 1
            # if(count1 == 5): break
        
        count += 1
    f.close()

main()