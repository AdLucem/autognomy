"""
    Taken from:
    https://github.com/ArmindoFlores/ao3_api/blob/master/AO3/works.py

    Loads only the information about a work using only the first page of a work. Thus runs faster on large works than the original ao3-api
"""
import warnings
from datetime import datetime
from functools import cached_property

from bs4 import BeautifulSoup

from . import threadable, utils
from AO3.chapters import Chapter
from .comments import Comment
from .requester import requester
from .users import User

class FasterWork:
    """
    Barebones AO3 work object
    """

    def __init__(self, workid):
        """Creates a new AO3 work object
        Args:
            workid (int): AO3 work ID
        Raises:
            utils.InvalidIdError: Raised if the work wasn't found
        """

        self._session = session
        self.chapters = []
        self.id = workid
        self._soup = None
        if load:
            self.reload(load_chapters)