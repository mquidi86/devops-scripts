#!/usr/local/bin/python3

import sys,json
import datetime

json_output = json.load(sys.stdin)
time_columns = sys.argv[1].split(",")
#print (time_columns)

for row in json_output:
    i = 0
    for value in row:
        #print (type(value))
        if str(i) in time_columns and isinstance(value,int):
            #print ("hola", end ="\t|\t")
            #print (value, end ="\t|\t")
            time_value=datetime.datetime.utcfromtimestamp(value/1000)
            print (time_value, end =" | ")
        else:
            print (value, end =" | ")
        #print (i, end ="\t|\t")
        i+=1
    print ("\n")
