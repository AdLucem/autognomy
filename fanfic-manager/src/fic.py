import AO3
import signal


def retrieve_with_sigalarm(work_id, max_time):
    """Retrieve a fic, but kill function if it takes time > max_time seconds"""

    def timeout_handler(num, stack):
        print("Received SIGALRM: fic retrieval taking too long")
        raise Exception("Fic retrieval taking too long")

    signal.signal(signal.SIGALRM, timeout_handler)

    signal.alarm(max_time)

    try:
        work = AO3.Work(work_id, load_chapters=False)
    except Exception as ex:
        print(ex)
        work = None

    return work


class Fic:
    """My own class for storing a Fic object"""

    def __init__(self, work_id="", from_dict=False, d={}):

        if from_dict:
            self.from_dict(d)
            self.url = "https://archiveofourown.org/works/" + str(self.work_id)

        elif not from_dict:
            self.work_id = work_id 
            self.url = "https://archiveofourown.org/works/" + str(self.work_id)

            self.work = retrieve_with_sigalarm(work_id, 10)

            if self.work:
                self.title = self.work.title
                self.fandoms = self.work.fandoms

                self.tags = self.work.tags
                self.characters = self.work.characters
                self.relationships = self.work.relationships
                self.summary = self.work.summary

    def __repr__(self):

        s = ""
        # s += "=============================================\n"
        s += '[{TITLE}]({URL})\n'.format(TITLE=self.title, URL=self.url)
        s += str(self.fandoms) + "\n"
        # s += "---------------------------------------------\n"
        s += "Characters: " + str(self.characters) + "\n"
        s += "Tags: " + str(self.tags) + "\n"
        s += "Relationships: " + str(self.relationships) + "\n"
        # s += "---------------------------------------------\n"
        s += self.summary + "\n"
        # s += "---------------------------------------------\n"
        return s

    def to_dict(self):

        d = {"work_id": self.work_id,
             "title": self.title,
             "fandoms": self.fandoms,
             "tags": self.tags,
             "characters": self.characters,
             "relationships": self.relationships,
             "summary": self.summary}

        return d
        
    def from_dict(self, d):

        self.work_id = d["work_id"]
        self.title = d["title"]
        self.fandoms = d["fandoms"]
        self.tags = d["tags"]
        self.characters = d["characters"]
        self.relationships = d["relationships"]
        self.summary = d["summary"]
