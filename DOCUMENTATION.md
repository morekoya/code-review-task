# Documentation of the changes made

In the refactoring of this code, the first thing I noticed was that the file was not in the proper rails code format. After putting it into that format, I noticed the fact that there was no protected keyword. The protected keyword keeps methods from being mistakenly called, so I added the protected keyword to separate the methods. The articleParams method was improperly named so I renamed it article_params everywhere it was called.

Next, I noticed that the index method was too long. I resolved to take out the code that was unnecessary to be in a controller. I created a concerns folder and also created query and type files within it. The query file holds the details of the boundaries. The type file holds the details of the article types, whether the article belongs to tag, author or favorited.

Finally, I simplified the long line in the show and destroy methods. I created an output file in the concerns folder. Then I took out the similar lines to form a `not_owned` method within the output file.