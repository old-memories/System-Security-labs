from zoodb import *
from debug import *

import hashlib
import random
import os
import pbkdf2

def login(username, password):
    db_person = person_setup()
    person = db_person.query(Person).get(username)
    if not person:
        return False
    return True

def register(username, password):
    db_person = person_setup()
    person = db_person.query(Person).get(username)
    if person:
        return False
    newperson = Person()
    newperson.username = username
    db_person.add(newperson)
    db_person.commit()
    return True

def newtoken(db, cred):
    hashinput = "%s%.10f" % (cred.password, random.random())
    cred.token = hashlib.md5(hashinput.encode('utf-8')).hexdigest()
    db.commit()
    return cred.token

def get_cred(username, password):
    db_cred = cred_setup()
    cred = db_cred.query(Cred).get(username)
    if cred and cred.password == pbkdf2.PBKDF2(password, cred.salt).hexread(32):
        return newtoken(db_cred, cred)
    else:
        return None

def create_cred(username, password):
    db_cred = cred_setup()
    cred = db_cred.query(Cred).get(username)
    if cred:
        return None
    newcred = Cred()
    newcred.username = username

    salt = os.urandom(32)
    newcred.salt = salt
    newcred.password = pbkdf2.PBKDF2(password, salt).hexread(32)
    db_cred.add(newcred)
    db_cred.commit()
    return newtoken(db_cred, newcred)

def check_token(username, token):
    db = cred_setup()
    cred = db.query(Cred).get(username)
    if cred and cred.token == token:
        return True
    else:
        return False

    
