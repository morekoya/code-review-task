# Documentation of the changes made

In the refactoring of this code, the first thing I noticed was that the file was not in the proper rails code format. I put it into an appropriate format and renamed the ruby file. I also removed the files that had nothing to do with this code.

I noticed that there was no protected keyword. The protected keyword keeps methods that are meant to be restricted to the class. This means that only methods in that class can make use of the methods in the protected keyword, so I added the protected keyword to separate the methods. The articleParams method was improperly named so I renamed it article_params everywhere it was called. The `set_requester_id` method was created to set the requester id and the `find_article` was created to find an article by slug. These methods were placed in the protected keyword.

There was a `Large Class` code smell in the index method which made it too long, so I decided to extract classes. I created a `queries` folder and also created an `article_query` file within it. The `article_query` receives the params and the articles returned depends on whether the params were `tag`, `author` or `favorited`. The pagination information went into this file. The feed method also contained this code so it was refactored.

Finally, The article model file was also created in the models folder. It holds the `validate_ownership` which handles the error handling and works only on update and delete. This was done to eliminate the `Tell Don't Ask` code smell that was obvious around the update and delete methods. 
