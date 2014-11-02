from TOSSIM import *
from  parse_config import *
import sys

small_nodes = 3
small_t, small_r = parse_config("small_linkgain.out", small_nodes, "small.out")
small_t.addChannel("SimpleMessageC", sys.stdout)
#small_t.addChannel("Receive", sys.stdout)
for i in xrange(0, small_nodes):
    n = small_t.getNode(i)
    n.bootAtTime(1002 * i + 1);
for i in xrange(0, 1000):
    small_t.runNextEvent()

