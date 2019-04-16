Created By:
Alekhya
StudentId: 18210618
email: alekhya.singh7@mail.dcu.ie
-------------------------------------------

A = LOAD '/FinalHive' using PigStorage('*') AS (id:int,posttypeid:int, score:int, viewcount:int, owneruserid:int, body:chararray, ownerdisplayname:chararray, title:chararray);

STORE A INTO 'pigdb.pigtable' USING org.apache.hive.hcatalog.pig.HCatStorer();
