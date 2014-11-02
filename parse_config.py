from TOSSIM import *


def parse_config(gain_file="", num_nodes=0, topology_file="", noise_tracing_file="meyer-heavy.txt"):
    t = Tossim([])
    r = t.radio()
    defined_by_gain = False
    if gain_file:
        lines = open(gain_file, 'r').readlines()
        for line in lines:
            s = line.split()
            if len(s) == 4:
                if s[0] == "gain":
                    defined_by_gain = True
                    r.add(int(s[1]), int(s[2]), float(s[3]))
    if (not defined_by_gain) and topology_file:
        lines = open(topology_file, 'r').readlines()
        for line in lines:
            s = line.split()
            if len(s) == 3:
                r.add(int(s[0]), int(s[1]), float(s[2]))
    lines = open(noise_tracing_file, "r").readlines()
    for line in lines:
        line = line.strip()
        if line:
            point = int(line)
            for i in xrange(0, num_nodes):
                t.getNode(i).addNoiseTraceReading(point)
    for i in xrange(0, num_nodes):
        t.getNode(i).createNoiseModel()
    return (t, r)
