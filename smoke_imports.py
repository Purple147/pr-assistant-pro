# smoke_imports.py
import os, sys, importlib

IGNORE = {'.venv','venv','__pycache__','.git','.github','node_modules'}
candidates = []
for name in os.listdir('.'):
    if name in IGNORE: 
        continue
    if os.path.isdir(name) and os.path.exists(os.path.join(name,'__init__.py')):
        candidates.append(('pkg', name))
    elif name.endswith('.py') and not name.startswith('test') and name not in ('setup.py',):
        candidates.append(('file', name))

print("candidates:", candidates)

for typ, name in candidates:
    try:
        if typ == 'file':
            with open(name, 'r', encoding='utf-8') as f:
                src = f.read()
            compile(src, name, 'exec')
            print('OK SYNTAX:', name)
        else:
            m = importlib.import_module(name)
            print('OK IMPORT:', name)
            if hasattr(m, 'create_app'):
                try:
                    a = m.create_app()
                    print('create_app() OK for', name)
                except Exception as e:
                    print('create_app() FAILED for', name, '->', repr(e))
    except Exception as e:
        print('ERROR', name, '->', repr(e))
