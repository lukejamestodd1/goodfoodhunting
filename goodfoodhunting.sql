CREATE DATABASE goodfoodhunting;

CREATE TABLE dishes (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  image_url VARCHAR(200) 
);

INSERT INTO dishes (name, image_url) VALUES ('fried donuts', 'http://s3.amazonaws.com/foodspotting-ec2/reviews/5714113/thumb_600.jpg?1453015528?1453075052');

INSERT INTO dishes (name, image_url) VALUES ('ribs and chips','http://s3.amazonaws.com/foodspotting-ec2/reviews/4281381/thumb_600.jpg?1385803706?1453075144');

INSERT INTO dishes (name, image_url) VALUES ('nutella bomba','http://s3.amazonaws.com/foodspotting-ec2/reviews/4281381/thumb_600.jpg?1385803706?1453075144');

CREATE TABLE dish_types(
	id SERIAL4 PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

INSERT INTO dish_types (name) VALUES ('snack');
INSERT INTO dish_types (name) VALUES ('dessert');
INSERT INTO dish_types (name) VALUES ('lunch');

ALTER TABLE dishes ADD dish_type_id INTEGER; 
ALTER TABLE dishes ADD venue VARCHAR(100);


CREATE TABLE users (
	id SERIAL4 PRIMARY KEY,
	email VARCHAR(200) NOT NULL,
	password_digest VARCHAR(400) NOT NULL

);

CREATE TABLE likes (
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER NOT NULL,
	dish_id INTEGER NOT NULL
);

call it password_digest because that's what Active Record likes

[1] pry(main)> User.new
=> #<User:0x007fd94ba37790 id: nil, email: nil, password_digest: nil>
[2] pry(main)> user2 = User.new
=> #<User:0x007fd94caa5c80 id: nil, email: nil, password_digest: nil>
[3] pry(main)> user2.password = 'pudding'
=> "pudding"
[4] pry(main)> user2
=> #<User:0x007fd94caa5c80
 id: nil,
 email: nil,
 password_digest:
  "$2a$10$pjDKdlNIwPNpdrwvL9Epn.jOzR0JHizLHLpE0r3N.HwnLeLY8FNVe">
[5] pry(main)>

AUTHENTICATION

[6] pry(main)> user2.authenticate('1234')
=> false
[7] pry(main)> user2.authenticate('pudding')
=> #<User:0x007fd94caa5c80
 id: nil,
 email: nil,
 password_digest:
  "$2a$10$pjDKdlNIwPNpdrwvL9Epn.jOzR0JHizLHLpE0r3N.HwnLeLY8FNVe">
[8] pry(main)>


MUST SAVE USER AFTER CREATING



