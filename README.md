# Documentation of the changes made

In the refactoring of this code, the first thing I noticed was that the file was not in the proper rails code format. After putting it into that format and renaming the ruby file, I noticed the fact that there was no protected keyword. The protected keyword keeps methods from being mistakenly called, so I added the protected keyword to separate the methods. The articleParams method was improperly named so I renamed it article_params everywhere it was called.

I then noticed that the index method was too long. I resolved to take out the code that was unnecessary to be in a controller. I created a `queries` folder and also created an `article_query` file within it. The `article_query` file figures out which params is necessary to get the articles to be seen. The pagination information also went into this file. The feed method also contained this so it was also refactored.

Finally, the article model file was created in the models folder. It holds the `validate_ownership` which handles the error handling and works only on update and delete.
