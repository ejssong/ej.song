library(sqldf)
file <-read.csv('SWE sample data - Q3 data.csv', sep = ',')

#Q1 
#Consider only the rows with country_id = "BDV" (there are 844 such rows). 
#For each site_id, we can compute the number of unique user_id's found in these 844 rows.
#Which site_id has the largest number of unique users?
#LC375A is the largest number of unique users.
#And what's the number?
#It's 544
unique_user <- sqldf("SELECT data.user_id, count(data.site_id) as NUM_SITE, data.country_id
                     FROM (SELECT DISTINCT user_id, site_id, country_id
                     FROM file 
                     WHERE country_id = 'BDV') AS data
                     GROUP BY data.site_id
                     ORDER BY NUM_SITE")

#Q2
#Between 2019-02-03 00:00:00 and 2019-02-04 23:59:59, 
#there are four users who visited a certain site more than 10 times. 
#Find these four users & which sites they (each) visited more than 10 times. 
#(Simply provides four triples in the form (user_id, site_id, number of visits) in the box below.)

find_user <- sqldf("SELECT data.user_id, data.site_id, count(data.site_id) as NUM_VISIT
                   FROM (SELECT DISTINCT user_id, site_id, ts
                   FROM file 
                   WHERE ts > '2019-02-03 00:00:00' and ts < '2019-02-04 23:59:59') AS data
                   GROUP BY data.user_id, data.site_id 
                   HAVING COUNT(data.site_id) > 10
                   ORDER BY NUM_VISIT DESC")

#Q3For each site, compute the unique number of users whose last visit
#(found in the original data set) was to that site. 
#For instance, user "LC3561"'s last visit is to "N0OTG" based on timestamp data. 
#Based on this measure, what are top three sites? 
#(hint: site "3POLC" is ranked at 5th with 28 users whose last visit in the data 
#set was to 3POLC; simply provide three pairs in the form (site_id, number of users).)

top_three <- sqldf("SELECT file.site_id, COUNT(file.user_id) AS COUNT_DATA 
                   FROM file 
                   INNER JOIN (SELECT *, MAX(ts) AS LASTEST_VISIT
                   FROM file
                   GROUP BY user_id) AS data
                   ON file.user_id = data.user_id AND file.site_id = data.site_id
                   AND file.ts = LASTEST_VISIT
                   GROUP BY file.site_id
                   ORDER BY COUNT_DATA DESC
                   LIMIT 3")


#Q4
#For each user, determine the first site he/she visited and 
#the last site he/she visited based on the timestamp data. 
#Compute the number of users whose first/last visits are to the same website.
#What is the number?

num <- sqldf ("SELECT COUNT(F.user_id)
               FROM (SELECT DISTINCT *
                    FROM file AS a
                    JOIN (SELECT * , MIN(min.ts) as FIRST_VISIT 
                          FROM FILE AS min
                          GROUP BY min.user_id
                          ORDER BY min.user_id) as FIRST 
                    ON FIRST_VISIT = a.ts 
                    AND FIRST.user_id = a.user_id 
                    AND FIRST.site_id = a.site_id
                    
                    )AS F
              JOIN (
                    SELECT DISTINCT *
                    FROM file AS a 
                    JOIN (SELECT * , MAX(max.ts) as LAST_VISIT
                          FROM FILE AS max
                          GROUP BY max.user_id
                          ORDER BY max.user_id) as LAST
                    ON LAST_VISIT = a.ts
                    AND LAST.user_id = a.user_id 
                    AND LAST.site_id = a.site_id
                    )AS L
              ON F.site_id = L.site_id 
              AND F.user_id = L.user_id
               ")


