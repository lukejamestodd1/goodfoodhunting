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


[27] pry(main)> Like.where(user_id: 1)
D, [2016-01-22T11:11:32.110985 #55653] DEBUG -- :   Like Load (4.1ms)  SELECT "likes".* FROM "likes" WHERE "likes"."user_id" = $1  [["user_id", 1]]
=> [#<Like:0x007f96f2d9e0a0 id: 1, user_id: 1, dish_id: 1>,
 #<Like:0x007f96f2d9df38 id: 2, user_id: 1, dish_id: 4>,
 #<Like:0x007f96f2d9ddd0 id: 3, user_id: 1, dish_id: 3>,
 #<Like:0x007f96f2d9dc90 id: 4, user_id: 1, dish_id: 5>,
 #<Like:0x007f96f2d9db00 id: 5, user_id: 1, dish_id: 4>]
[28] pry(main)> User.all
D, [2016-01-22T11:11:44.182191 #55653] DEBUG -- :   User Load (1.9ms)  SELECT "users".* FROM "users"
=> [#<User:0x007f96f2ba40d8
  id: 1,
  email: "cake@pudding.com",
  password_digest:
   "$2a$10$pjDKdlNIwPNpdrwvL9Epn.jOzR0JHizLHLpE0r3N.HwnLeLY8FNVe">]
[29] pry(main)> u1 = User.first
D, [2016-01-22T11:11:56.917336 #55653] DEBUG -- :   User Load (1.6ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" ASC LIMIT 1
=> #<User:0x007f96f2a9fea8
 id: 1,
 email: "cake@pudding.com",
 password_digest:
  "$2a$10$pjDKdlNIwPNpdrwvL9Epn.jOzR0JHizLHLpE0r3N.HwnLeLY8FNVe">
[30] pry(main)> u1.likes
D, [2016-01-22T11:12:08.126871 #55653] DEBUG -- :   Like Load (0.4ms)  SELECT "likes".* FROM "likes" WHERE "likes"."user_id" = $1  [["user_id", 1]]
=> [#<Like:0x007f96f2d5fc60 id: 1, user_id: 1, dish_id: 1>,
 #<Like:0x007f96f2d5fad0 id: 2, user_id: 1, dish_id: 4>,
 #<Like:0x007f96f2d5f8c8 id: 3, user_id: 1, dish_id: 3>,
 #<Like:0x007f96f2d5f6c0 id: 4, user_id: 1, dish_id: 5>,
 #<Like:0x007f96f2d5f3c8 id: 5, user_id: 1, dish_id: 4>]
[31] pry(main)>
