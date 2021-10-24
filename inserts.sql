
--Inserting into UTC_offset

INSERT INTO UTC_offset (time_zone,utc_offset)
SELECT DISTINCT user_time_zone,user_utc_offset 
FROM bad_giant_table 
WHERE user_time_zone IS NOT null;


--Inserting into Users

INSERT INTO Users (user_id,user_name,user_screen_name, user_location, user_time_zone, user_followers_count, user_friends_count, user_lang, user_description, user_status_count, user_created_at)
SELECT  DISTINCT user_id, user_name,user_screen_name, user_location, user_time_zone, user_followers_count, user_friends_count, user_lang, user_description, user_status_count, user_created_at
FROM bad_giant_table ;



--Inserting into Tweets

INSERT INTO  Tweets (created_at ,text,tweet_id,tweet_source,user_id)
SELECT  created_at ,text,tweet_id,tweet_source,user_id
FROM bad_giant_table;


--Inserting into Replies

INSERT INTO  Replies(tweet_id,in_reply_to_status_id)
SELECT tweet_id, in_reply_to_status_id
FROM bad_giant_table
WHERE in_reply_to_status_id IS NOT null AND in_reply_to_status_id IN (SELECT tweet_id FROM  bad_giant_table);


--Inserting into Retweets

INSERT INTO  Retweets(tweet_id, retweet_of_tweet_id)
SELECT tweet_id, retweet_of_tweet_id
FROM bad_giant_table
WHERE retweet_of_tweet_id IS NOT null AND retweet_of_tweet_id IN (SELECT tweet_id FROM  bad_giant_table);


--Inserting into Hashtags

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag1 
FROM bad_giant_table
WHERE hashtag1 IS NOT null; 

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag2
FROM bad_giant_table
WHERE hashtag2 IS NOT null AND hashtag2 NOT IN (SELECT hashtag_name FROM  Hashtags); 

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag3
FROM bad_giant_table
WHERE hashtag3 IS NOT null AND hashtag3 NOT IN (SELECT hashtag_name FROM  Hashtags); 

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag4
FROM bad_giant_table
WHERE hashtag4 IS NOT null AND hashtag4 NOT IN (SELECT hashtag_name FROM  Hashtags); 

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag5
FROM bad_giant_table
WHERE hashtag5 IS NOT null AND hashtag5 NOT IN (SELECT hashtag_name FROM  Hashtags); 

INSERT INTO Hashtags(hashtag_name) 
SELECT DISTINCT hashtag6
FROM bad_giant_table
WHERE hashtag6 IS NOT null AND hashtag6 NOT IN (SELECT hashtag_name FROM  Hashtags); 



--Inserting into Tweets_with_hashtags

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag1;

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag2
ON CONFLICT DO NOTHING;

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag3
ON CONFLICT DO NOTHING;

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag4
ON CONFLICT DO NOTHING;

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag5
ON CONFLICT DO NOTHING;

INSERT INTO  Tweets_with_hashtags(tweet_id, hashtag_id)
SELECT tweet_id,hashtag_id
FROM bad_giant_table,hashtags
WHERE hashtags.hashtag_name = bad_giant_table.hashtag6
ON CONFLICT DO NOTHING;


--View to store user_status_count
create view user_tweet_count as select users.user_id,count(tweet_id) from users full outer join tweets on tweets.user_id = users.user_id group by users.user_id;

--View to store retweet_count
create view retweet_count as select tweets.tweet_id, count(retweets.*) from tweets full outer join retweets on tweets.tweet_id=retweets.retweet_of_tweet_id group by tweets.tweet_id;