import argparse

"""Note down two things:
    Reading: list of papers I'm reading
    Working on: Things I'm working on
Perform CRUD operations on these.
"""


def mk_argparse():

    parser = argparse.ArgumentParser()

    parser.add_argument("--add", 
                        help="Add to given field",
                        action="store_true")
    parser.add_argument("--list", 
                        help="List elements in field",
                        action="store_true")
    parser.add_argument("--remove", 
                        help="Remove element from given field",
                        action="store_true")
    parser.add_argument("--refresh", 
                        help="Remove all from given field",
                        action="store_true")

    parser.add_argument("--in", choices=["reading", "working"], 
                        help="""Do you want to access: 
                        things being  read, or things being worked on?""")
    
    return parser


def process_args(args):

    pass


if __name__ == "__main__":
    
    parser = mk_argparse()
    args = parser.parse_args()
