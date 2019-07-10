# Data-Analysis (using pig and hive) 

The objective is to work on a large amount of data, with the BigData technologies (Hadoop, Hive and Pig).

Implemented EMR cluster to run Hadoop on AWS and migrated data from raw file to Hive table.

Tasks :

        1. Acquire the top 200,000 posts by viewcount.

        2. Using pig or mapreduce, extract, transform and load the data as applicable

        3. Using hive and/or mapreduce, get:

        ◦ The top 10 posts by score

        ◦ The top 10 users by post score

        ◦ The number of distinct users, who used the word hadoop in one of their posts

        4. Using mapreduce calculate the per-user TF-IDF (just submit the top 10 terms for each user)

Steps to be followed:

    • Collected data from Stack Exchange database using SQL query. 
The database is available here: http://data.stackexchange.com/stackoverflow/query/new

    • select count(*) from posts where posts.ViewCount > 58000

    • Similarly, run the above query 4 times by using the join method and a range of 50K posts each to collect 200000 posts. On StackExchange, we can only dump 50K posts.
