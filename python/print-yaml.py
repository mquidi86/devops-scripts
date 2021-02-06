import yaml

filename = 'hola2'

raw = open(filename).read()
docs = []
for raw_doc in raw.split('\n---'):
    try:
        docs.append(yaml.load(raw_doc))
    except SyntaxError:
        docs.append(raw_doc)
