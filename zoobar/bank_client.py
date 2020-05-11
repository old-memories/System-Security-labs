from debug import *
from zoodb import *
import rpclib

sys.path.append(os.getcwd())
import readconf

def transfer(sender, recipient, zoobars):
    ## Fill in code here.
    host = readconf.read_conf().lookup_host('bank')
    with rpclib.client_connect(host) as c:
        ret = c.call('transfer', sender=sender, recipient=recipient, zoobars=zoobars)
        return ret

def balance(username):
    ## Fill in code here.
    host = readconf.read_conf().lookup_host('bank')
    with rpclib.client_connect(host) as c:
        ret = c.call('balance', username=username)
        return ret

def get_log(username):
    ## Fill in code here.
    host = readconf.read_conf().lookup_host('bank')
    with rpclib.client_connect(host) as c:
        ret = c.call('get_log', username=username)
        return ret

def check_in(username):
    ## Fill in code here.
    host = readconf.read_conf().lookup_host('bank')
    with rpclib.client_connect(host) as c:
        ret = c.call('check_in', username=username)
        return ret