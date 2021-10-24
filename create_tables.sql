
--Creating table for UTC_offset

CREATE TABLE UTC_offset(
    time_zone character varying(127),
    user_followers_count integer,
    PRIMARY KEY(time_zone)
);



--Creating table for Users

CREATE TABLE Users(
    user_id bigint,
    user_name character varying(255),
    user_screen_name  character varying(255),
    user_location character varying(255), 
    user_time_zone character varying(127),
    user_followers_count integer,
    user_friends_count integer,
    user_lang character varying(10),
    user_description varchar(255),
    user_status_count varchar(255),
    user_created_at timestamp with time zone,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_time_zone) REFERENCES UTC_offset(time_zone)
);



--Creating table for Tweets

CREATE TABLE Tweets (
    created_at timestamp with time zone,
    text varchar(255),
    tweet_id bigint,
    tweet_source  varchar(255),
    user_id bigint,
    PRIMARY KEY (tweet_id),
    FOREIGN KEY (user_id ) REFERENCES Users(user_id)
);

--Creating table for Replies

CREATE TABLE Replies(
    tweet_id bigint,
    in_reply_to_status_id bigint,
    PRIMARY KEY (tweet_id,in_reply_to_status_id),
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id),
    FOREIGN KEY (in_reply_to_status_id) REFERENCES Tweets(tweet_id)
);


--Creating table for Retweets

CREATE TABLE Retweets(
    tweet_id bigint,
    retweet_of_tweet_id bigint,
    PRIMARY KEY (tweet_id),
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id),
    FOREIGN KEY (retweet_of_tweet_id) REFERENCES Tweets(tweet_id)
);


--Creating table for Hashtags

CREATE TABLE Hashtags(
    hashtag_id  SERIAL,
    hashtag_name varchar(144),
    PRIMARY KEY(hashtag_id)
);


--Creating table for Tweets_with_hashtags

CREATE TABLE Tweets_with_hashtags(
    tweet_id bigint,
    hashtag_id int,
    PRIMARY KEY(tweet_id,hashtag_id),
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id),
    FOREIGN KEY (hashtag_id) REFERENCES Hashtags(hashtag_id)
);
