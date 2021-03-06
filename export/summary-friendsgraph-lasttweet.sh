#!/bin/bash
# ./friendsgraph-lasttweet.sh '<COLLECTION_NAME>' <UNIX_TIMESTAMP>
# Run with ./friendsgraph-lasttweet.sh '2014-12-05' 1417456357000
# Use a unix timestamp generation tool such as http://www.epochconverter.com/ (Timestamp in milliseconds)

DBNAME=$1
COLNAME=$2
LTDATE=$3
EXP_PATH=$4
OUTPUT_FILES=$5

#OUTPUT_FILES="/Users/antoinebrunel/Downloads"
#DBNAME=tucat_twitter_extraction
#QUERY="{follower : {\$ne : [ ]}, dtstatuscreatedat : {\$gte : new Date($2) }}"
QUERY="{follower : {\$ne : [ ]}, dtstatuscreatedat : {\$gte : new Date($LTDATE) }}"
MONGO_FIELDS_NODE='screenname,name,topuser,followerscount,listedcount,statusescount,friendscount,lang,statussource,statuscreatedat'
GRAPH_FIELDS_NODE='nodedef>name VARCHAR,label VARCHAR,type VARCHAR, followerscount INT,listedcount INT,statusescount INT,friendscount INT,lang VARCHAR,statussource VARCHAR,statuscreatedat VARCHAR'
MONGO_FIELDS_EDGE='follower,screenname'
GRAPH_FIELDS_EDGE='edgedef>node1 VARCHAR,node2 VARCHAR'
FRIENDORFOLLOWER='follower'

#echo "OXSI-TUCAT: Starting data export"

#echo "Step 1> Aggregating Mongodb data"
#COLLECTION=$(mongo --quiet --eval "var dbname='$DBNAME', colname='$1', ltdate=$2, friendfollower='$FRIENDORFOLLOWER'" $3aggregation.js)
COLLECTION=$(mongo --quiet --host $MONGOHOST --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD admin --eval "var dbname='$DBNAME', colname='$COLNAME', ltdate=$LTDATE, friendfollower='$FRIENDORFOLLOWER'" "$EXP_PATH"aggregation.js)

#echo "Step 2> Exporting node data > archivo-node-$1-$COLLECTION.csv"
#mongoexport --quiet --db $DBNAME --collection $1 --fields $MONGO_FIELDS_NODE --query "$QUERY" --csv -o "$OUTPUT_FILES/summary-node-$1-$2-$COLLECTION.csv"
#mongo --quiet --eval "db.getSiblingDB('$DBNAME')['$COLLECTION'].drop()"
mongoexport --quiet --host $MONGOHOST --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin --db $DBNAME --collection $COLNAME --fields $MONGO_FIELDS_NODE --query "$QUERY" --csv -o "$OUTPUT_FILES/summary-node-$COLNAME-$COLLECTION.csv"
mongo --quiet --host $MONGOHOST --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD admin --eval "db.getSiblingDB('$DBNAME')['$COLLECTION'].drop()"

#echo "$OUTPUT_FILES/summary-node-$1-$2-$COLLECTION.csv"
echo "summary-node-$COLNAME-$COLLECTION.csv"
