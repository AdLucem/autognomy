import AO3
import argparse
import json
import time


"""My own class for storing a Fic object"""
class Fic:

    def __init__(self, work_id="", from_dict=False, d={}):

        if from_dict:
            self.from_dict(d)

        elif not from_dict:
            self.work_id = work_id 
            self.work = AO3.Work(self.work_id, load=False, load_chapters=False)

            self.title = self.work.title()
            # self.fandoms = self.work.fandoms

            # self.tags = self.work.tags
            # self.characters = self.work.characters
            # self.relationships = self.work.relationships
            # self.summary = self.work.summary

    def __repr__(self):

        s = ""
        s += "=============================================\n"
        s += self.title + "\n"
        s += str(self.fandoms) + "\n"
        s += "---------------------------------------------\n"
        s += "Characters: " + str(self.characters) + "\n"
        s += "Tags: " + str(self.tags) + "\n"
        s += "Relationships: " + str(self.relationships) + "\n"
        s += "---------------------------------------------\n"
        s += self.summary + "\n"
        s += "---------------------------------------------\n"
        return s

    def to_dict(self):

        d = {
                "work_id": self.work_id,
                "title": self.title,
                "fandoms": self.fandoms,
                "tags": self.tags,
                "characters": self.characters,
                "relationships": self.relationships,
                "summary": self.summary
        }

        return d
        
    def from_dict(self, d):

        self.work_id = d["work_id"]
        self.title = d["title"]
        self.fandoms = d["fandoms"]
        self.tags = d["tags"]
        self.characters = d["characters"]
        self.relationships = d["relationships"]
        self.summary = d["summary"]


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

    with open("m4l.txt") as f:
        works4l = [int(line.rstrip("\n")) for line in f.readlines() if line.rstrip("\n") != ""]

    storage = []

    worksToLoad = []
    for work_id in works4l:
        try: 
            worksToLoad.append(AO3.Work(work_id, load=False))
        except AttributeError:
            continue

    works = []
    threads = []
    start = time.time()
    for work in worksToLoad:
        works.append(work)
        threads.append(work.reload(threaded=True))
    for thread in threads:
        thread.join()
    print(f"Loaded {len(works)} works in {round(time.time()-start, 1)} seconds.")

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
