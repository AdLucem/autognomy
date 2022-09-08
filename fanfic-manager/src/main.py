import AO3
import argparse
import json
from fic import Fic


def login(username, password):
    """Start a session logged in as an user with given config. Return: a ao3-api `session` object"""

    session = AO3.Session(username, password)
    return session


def get_m4l(session):
    """Get all works in Marked For Later. Returns: a list of [Work]"""

    works_for_later = session.get_marked_for_later()
    return works_for_later


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Download all fics in your Marked For Later list, sort by fandom and store in a easily readable markdown file')
    parser.add_argument('--username', type=str, help="Username of account.")
    parser.add_argument('--password', type=str, help="Password of account.")

    args = parser.parse_args()

    with open("m4l.json") as f:
        fics_json = json.load(f)

    fics = []
    for fic_json in fics_json:
        obj = Fic(from_dict=True, d=fic_json)
        fics.append(obj)

    fandoms = {}
    for fic in fics:
        fandom = fic.fandoms[0]

        if fandom in fandoms:
            fandoms[fandom].append(fic)
        else:
            fandoms[fandom] = [fic]

    for fandom in fandoms:
        print("+++++++++++++++++++++++++++++++++++\n")
        print("## " + fandom + "\n")
        for fic in fandoms[fandom]:
            print(fic)
        print("+++++++++++++++++++++++++++++++++++\n")

    """
    session = login(args.username, args.password)
    
    works4l = get_m4l(session)
    # with open("m4l.txt") as f:
    #    data = [s.rstrip("\n") for s in f.readlines()]

    works = []
    
    for work in works4l:
        work_id = work.id
        print("Retrieving work {work_id}".format(work_id=work_id))
        work_obj = Fic(work_id=work_id)
        if work_obj.work:
            work_dict = work_obj.to_dict()
            works.append(work_dict)

    with open("m4l.json", "w+") as f:
        json.dump(works, f)
    """

"""
    storage = []

    worksToLoad = []
    for work_id in works4l:
        try: 
            worksToLoad.append(AO3.Work(work_id, load=False))
        except AttributeError:
            continue
"""
"""
    for work_id in works4l:
        try:
            work_obj = Fic(work_id=work_id)
            storage.append(work_obj.to_dict())
        except AttributeError:
            continue

    with open("works_for_later.json", "w+") as f:
        json.dump(storage, f)


    session = login(args.username, args.password)
    works4l = get_m4l(session)

    for work in works4l:
        print(work.id)

    for work in works4l:
        try:
            work_obj = Fic(work_id=work.id)
            print(work_obj)
        except AttributeError:
            continue
"""
