#!/usr/local/bin/python3

import sys, logging
import urllib3

url = sys.argv[1]
file_dest = sys.argv[2]

import urllib3
http = urllib3.PoolManager()
r = http.request('GET', url, preload_content=False)

try:

    with open(file_dest, 'wb') as out:
        while True:
            data = r.read()
            if not data:
                break
            out.write(data)

    r.release_conn()

except:
    logging.error("damn")
    raise

print ( "hola" )
