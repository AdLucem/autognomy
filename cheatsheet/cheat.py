import json
import sys
from fuzzywuzzy import fuzz, process


FILENAME = sys.argv[1] + ".json"

cmds = {}


def max_match(s, ls):

    maxmatch = 0
    max_match_string = ""
    for s_ in ls:
        match = fuzz.token_sort_ratio(s, s_)

        if match >= maxmatch:
            maxmatch = match
            max_match_string = s_

    return max_match_string


if __name__ == "__main__":

    cmd = ""
    argslen = len(sys.argv)
    for i in range(2, argslen):
        cmd = cmd + " " + sys.argv[i]
    print(cmd)

    with open(FILENAME, "r+") as f:
        cmds = json.load(f)

    if cmd in cmds.keys():
        print(cmds[cmd])
    else:
        alt_cmd = max_match(cmd, cmds.keys())
        print(cmds[alt_cmd])






