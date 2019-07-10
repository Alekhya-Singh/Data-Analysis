## Data-Analysis (using pig and hive on Google Cloud Platform) 

The objective is to work on a large amount of data, with the BigData technologies (Hadoop, Hive and Pig).

Tasks :

        1. Acquire the top 200,000 posts by viewcount.

        2. Using pig or mapreduce, extract, transform and load the data as applicable

        3. Using hive and/or mapreduce, get:

        ◦ The top 10 posts by score

        ◦ The top 10 users by post score

        ◦ The number of distinct users, who used the word hadoop in one of their posts

        4. Using mapreduce calculate the per-user TF-IDF

Steps to be followed:

    • Collected data from Stack Exchange database using SQL query. 
The database is available here: http://data.stackexchange.com/stackoverflow/query/new

    • select count(*) from posts where posts.ViewCount > 58000

    • Similarly, run the above query 4 times by using the join method and a range of 50K posts each to collect 200000 posts. On StackExchange, we can only dump 50K posts.

### Using pig to extract, transform and load the data

First, start with creating a cluster in Data Proc:

Created an account in Google Cloud Platform and from there select data proc and create a cluster.
Implemented cluster to run Hadoop on Google Cloud Platform and performed data preprocessing in Hadoop.
        
   ![image](https://user-images.githubusercontent.com/43326618/61000261-f684f600-a354-11e9-8b02-c4604cfc6e9d.png)

   ![image](https://user-images.githubusercontent.com/43326618/60999880-1667ea00-a354-11e9-85ae-542ede18d66d.png)

Now connect to the cluster using PuTTy. Generate a key using Puttygen and use that key to connect to the cluster. Now        we can transfer the data.csv file to the cluster.

Go back to the cluster, select your cluster and click on SSH. You can see a console opens up and here we are in the          cluster.

Start the data preprocessing in Hadoop.

Now the data .csv is cleaned using pig with the help of below-mentioned
   
   ![image](https://user-images.githubusercontent.com/43326618/61000343-1ddbc300-a355-11e9-83a9-af341e768d3e.png)

command lines. It adds a \n tab at the spaces.

        sed ':a;N;$!ba;s/\n/\\n/g' data.csv > firstquery.csv
        sed s/\\n//g <firstquery.csv>secondquery.csv
        
   ![image](https://user-images.githubusercontent.com/43326618/61000442-5380ac00-a355-11e9-9860-7a44ba92e542.png)
        
After initial formatting of the file, we then put this file in the location of hdfs which could be achieved using the command.
        ◦ hdfs dfs -put secondquery.csv /F2
        
   ![image](https://user-images.githubusercontent.com/43326618/61000565-9c386500-a355-11e9-841c-7a609f7d4b1d.png)
      
 To load the data with the separator you can use CSVLoader. It’s a function of piggybank which has been taken from here:
        ◦ https://cwiki.apache.org/confluence/display/PIG/PiggyBank
        
Now the script: 

    • REGISTER piggybank.jar;
    • DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader();
    • A = LOAD '/F2' USING CSVLoader(',') AS (Id:int, PostTypeId:int, AcceptedAnswerId:int, ParentId:int, CreationDate:datetime, DeletionDate:datetime, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName: chararray, LastEditDate:datetime, LastActivityDate:datetime, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray);
    • B = FOREACH A GENERATE Id, PostTypeId, Score, ViewCount, OwnerUserId, Body, OwnerDisplayName, Title;
    • DUMP B;
    
   ![image](https://user-images.githubusercontent.com/43326618/61000732-fc2f0b80-a355-11e9-9643-a5f18119911f.png)

Now to export the dumped data in a readable format for Hive is our second step and to do this, we have to replace the DUMP B by:
   
        ◦ STORE B INTO '/FinalHive' USING PigStorage('*');	 	 	
        • After this, Pig has divided the result into 2 files in the hdfs. Since we have a log file which blocks the load function of the hive,  we have to delete the _SUCCESS.
        • So just run this command to delete the log file:
        ◦ hdfs dfs -rm /FinalHive/_SUCCESS
        
  ![image](https://user-images.githubusercontent.com/43326618/61000948-73649f80-a356-11e9-8ba1-53b8c97bd9af.png)

### Using hive to find top 10 posts by the score, top 10 users by post score and the number of distinct users, who used the word Hadoop in one of their posts applicable

   Created a database schema and tables. Using HCatalog, stored pig results in tables created in Hive.
   
   In Hive Console:
   
        ◦ Create database pigdb;
        ◦ Create table pigtable (Id int, PostTypeId int, Score int, ViewCount int, OwnerUserId int, Body string, OwnerDisplayName string, Title string);
    
   In pig -useHCatalog Console:
   
        ◦ grunt> A = LOAD '/FinalHive' using PigStorage('*') AS (id:int,posttypeId:int, score:int, viewcount:int, owneruserId:int, body:chararay, ownerdisplayname:chararray, title:chararray);
        ◦ grunt> STORE A INTO 'pigdb.pigtable USING org.apache.hive.hcatalog.pig.HCatStorer;
        
   Finally run the hive queries mentioned in hive.txt file
   
 ### Used python script for calculating the TF-IDF per user.


