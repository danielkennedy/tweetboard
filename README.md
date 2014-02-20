http://www.millwoodonline.co.uk/blog/sinatra-activerecord-postgres-application
- Install postgresql (FIXME: details)
- Create user
- Create database
- Grant access to user
- Create app.rb
- Create a migration (via 'rake db:create_migration NAME=create_notes')
- Put the "up" and "down" calls in the migrate file
- Migrate the DB via 'rake db:migrate'
- Start the app with "bundle exec rackup"
dan@dan-HP-EliteBook-8470w:~/code/sandbox/sinatra-activerecord-pg$ sudo su - postgres
[sudo] password for dan: 
postgres@dan-HP-EliteBook-8470w:~$ psql -d tweetboard
psql: FATAL:  database "tweetboard" does not exist
postgres@dan-HP-EliteBook-8470w:~$ psql tweetboard
psql: FATAL:  database "tweetboard" does not exist
postgres@dan-HP-EliteBook-8470w:~$ psql
psql (9.1.11)
Type "help" for help.

postgres=# CREATE USER tweetboard WITH PASSWORD 'tweetboard';
CREATE ROLE
postgres=# CREATE DATABASE tweetboard;
CREATE DATABASE
postgres=# GRANT ALL PRIVELEGES ON DATABASE tweetboard TO tweetboard;
ERROR:  syntax error at or near "PRIVELEGES"
LINE 1: GRANT ALL PRIVELEGES ON DATABASE tweetboard TO tweetboard;
                  ^
postgres=# GRANT ALL PRIVILEGES ON DATABASE tweetboard TO tweetboard;
GRANT
postgres=# \q
postgres@dan-HP-EliteBook-8470w:~$ exit
logout

