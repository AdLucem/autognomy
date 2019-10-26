
topic = ["leave", "extension"]

"""So take a kind of formal, frozen discourse, that has a given format which is
unlikely to change in the coming few years. Say, the business email.

Assuming we know the elements of that discourse,
we can enumerate them in our class here: (the `topic` element is for later use)
"""


class Details:

    def __init__(self):
        self.topic = ""
        self.name = ""
        self.body = [""]
        self.sign = ""


""" Each field within the record type holds some information
about that particular discourse element, from which we can
construct the entirety of that discourse element. In this case,
the elements are rather prosaic-
simply strings that the program concatenates together.

So our constructor functions for each discourse element are straightforward:

mkSubject :: Details -> String
mkBody :: Details -> String
mkSignature :: Details -> String
mkEmail :: Details -> String

You'll note that I haven't actually filled out any of the functions yet. That's because I wish to insert some NLP wizardry here.

Okay, so the most naive implementation of the `mkBody` function implies that the `contents` are given. As in, I've written out the email in a separate file, but for some reason I want this program to concatenate it.

What if that's not the case? I'm lazy, you see. I dislike writing emails. I want to blurt out a few words on the paper, and have it write an email for me.

However, it is a truth universally acknowledged, that a single man in possession of an auto-email-writing robot, would be in possesion of a large amount of data. I'm writing this program in half an hour, and cannot be arsed to clean and process the Enron dataset to make some markov chain write generated fraud-avoidance emails for me. So, well, I take an example and see what I can do with a few shiny NLP libraries."""

# here is my example
details = Details()
details.contents = ["nitwit", "blubber", "oddment", "tweak"]

# let's import NLTK and gensim's word embeddings, for starters.
# why? felt like it, that's why
# let's also import a language model, to complete the set

