Created By:
Alekhya
StudentId: 18210618
email: alekhya.singh7@mail.dcu.ie
-------------------------------------------

REGISTER piggybank.jar;


DEFINE CSVLoader

org.apache.pig.piggybank.storage.CSVLoader();

A = LOAD '/F2' USING CSVLoader(',') AS (Id:int, PostTypeId:int, AcceptedAnswerId:int, ParentId:int, CreationDate:datetime, DeletionDate:datetime, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName: chararray, LastEditDate:datetime, LastActivityDate:datetime, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray);

B = FOREACH A GENERATE Id, PostTypeId, Score, ViewCount, OwnerUserId, Body, OwnerDisplayName, Title;

DUMP B;

STORE B INTO '/FinalHive' USING PigStorage('*');
